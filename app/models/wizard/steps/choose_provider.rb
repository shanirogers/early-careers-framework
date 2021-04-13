# frozen_string_literal: true

module Wizard::Steps
  class ChooseProvider < Wizard::Step
    attribute :chosen_provider

    validates :chosen_provider, presence: true, if: :is_in_options?

    OPTIONS = {
      "abc_training_ltd": 2001,
      "cyberdyne_inc": 2002,
      "oscorp": 2003,
      "tyrell_corporation": 2004,
      "umbrella_corporation": 2005,
      "weyland_yutani": 2006,
    }.freeze

    def reviewable_answers
      super.tap do |answers|
        answers["chosen_provider"] = OPTIONS.key(:chosen_provider).to_s.capitalize
      end
    end

  private

    def is_in_options?
      OPTIONS.value?(:chosen_provider)
    end
  end
end
