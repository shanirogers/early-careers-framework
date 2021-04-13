# frozen_string_literal: true

module Wizard::Steps
  class ConfirmSchool < Wizard::Step
    attribute :confirm_school, :boolean

    validates :confirm_school, inclusion: { in: [true, false] }

    def reviewable_answers
      {}
    end
  end
end
