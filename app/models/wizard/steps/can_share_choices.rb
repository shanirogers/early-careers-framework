# frozen_string_literal: true

module Wizard::Steps
  class CanShareChoices < Wizard::Step
    attribute :can_share_choices, :boolean

    validates :can_share_choices, presence: true

    def reviewable_answers
      {}
    end
  end
end
