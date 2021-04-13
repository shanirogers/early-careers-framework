# frozen_string_literal: true

module Wizard::Steps
  class VerifyContactDetails < Wizard::Step
    include ActiveModel::Dirty

    IDENTITY_ATTRS = %i[email first_name last_name date_of_birth].freeze

    attribute :timed_one_time_password

    validates :timed_one_time_password, length: { is: 6 }, format: { with: /\A[0-9]*\z/ }
    validate :timed_one_time_password_is_correct, if: :perform_api_check?

    before_validation if: :timed_one_time_password do
      self.timed_one_time_password = timed_one_time_password.to_s.strip
    end

    def skipped?
      @store["authenticate"] != true
    end

    def export
      {}
    end

    def reviewable_answers
      {}
    end

    def candidate_identity_data
      @store.fetch(IDENTITY_ATTRS).compact.transform_keys do |k|
        k.camelize(:lower).to_sym
      end
    end

  private

    def perform_api_check?
      timed_one_time_password_valid?
    end

    def timed_one_time_password_valid?
      self.class.validators_on(:timed_one_time_password).each do |validator|
        validator.validate_each(self, :timed_one_time_password, timed_one_time_password)
      end
      errors.none?
    end

    def timed_one_time_password_is_correct
      @store["one_time_password"] == timed_one_time_password
    end
  end
end
