# frozen_string_literal: true

module Wizard
  class UnknownStep < RuntimeError; end
  class AccessTokenNotSupportedError < RuntimeError; end

  class Base
    module Auth
      ACCESS_TOKEN = 0
    end

    MATCHBACK_ATTRS = %i[candidate_id qualification_id].freeze

    class_attribute :steps

    class << self
      def indexed_steps
        @indexed_steps ||= steps.index_by(&:key)
      end

      def step(key)
        indexed_steps[key] || raise(UnknownStep, "Unknown step: " + key)
      end

      def key_index(key)
        steps.index step(key)
      end

      def step_keys
        indexed_steps.keys
      end

      def first_key
        step_keys.first
      end
    end

    delegate :step, :key_index, :indexed_steps, :step_keys, to: :class
    delegate :can_proceed?, to: :find_current_step, prefix: :step
    attr_reader :current_key

    def initialize(store, current_key)
      @store = store

      raise(UnknownStep) unless step_keys.include?(current_key)

      @current_key = current_key
    end

    def find(key)
      step(key).new self, @store
    end

    def find_current_step
      find current_key
    end

    def previous_key(key = current_key)
      earlier_keys(key).reverse.find do |k|
        !find(k).skipped?
      end
    end

    def next_key(key = current_key)
      later_keys(key).find do |k|
        !find(k).skipped?
      end
    end

    def first_step?
      previous_key.nil?
    end

    def last_step?
      next_key.nil?
    end

    def valid?
      active_steps.all?(&:valid?)
    end

    def can_proceed?
      active_steps.all?(&:can_proceed?)
    end

    def complete!
      last_step? && valid? && can_proceed?
    end

    def invalid_steps
      active_steps.select(&:invalid?)
    end

    def first_invalid_step
      active_steps.find(&:invalid?)
    end

    def first_exit_step
      active_steps.find(&:exit?)
    end

    def later_keys(key = current_key)
      steps[(key_index(key) + 1)..].to_a.map(&:key)
    end

    def earlier_keys(key = current_key)
      index = key_index(key)
      return [] unless index.positive?

      steps[0..(index - 1)].map(&:key)
    end

    def export_data
      matchback_data = @store.fetch(MATCHBACK_ATTRS)
      # Ensure skipped step data is overwritten by shown step data.
      # Important as two demo_one can write to the same attribute.
      skipped_steps_first = all_steps.partition(&:skipped?).flatten
      step_data = skipped_steps_first.map(&:export).reduce({}, :merge)
      step_data.merge!(matchback_data)
    end

    def reviewable_answers_by_step
      all_steps.reject(&:skipped?).each_with_object({}) do |step, hash|
        hash[step.class] = step.reviewable_answers
      end
    end

  private

    def prepopulate_store(response, auth_method)
      hash = response.to_hash.transform_keys { |k| k.to_s.underscore }
      hash["auth_method"] = auth_method
      @store.persist_crm(hash)
    end

    def all_steps
      step_keys.map(&method(:find))
    end

    def active_steps
      all_steps.reject(&:skipped?)
    end
  end
end
