# frozen_string_literal: true

module Wizard::Steps
  class ChooseNpq < Wizard::Step
    attribute :chosen_npq

    validates :chosen_npq, presence: true, if: :is_in_options?

    OPTIONS = {
      npq_senior_leadership: 1001,
      npq_leading_teacher_development: 1002,
      npq_executive_leadership: 1003,
      npq_leading_teaching: 1004,
      npq_headship: 1005,
      npq_leading_behaviour_and_culture: 1006,
    }.freeze

    def reviewable_answers
      super.tap do |answers|
        answers["chosen_npq"] = OPTIONS.key(:chosen_npq).to_s.capitalize
      end
    end

  private

    def is_in_options?
      OPTIONS.value?(:chosen_npq)
    end
  end
end
