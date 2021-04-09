# frozen_string_literal: true

module Wizard::Steps
  class AcceptPrivacyPolicy < Wizard::Step
    attribute :accepted_policy_id, :string

    # validates :accepted_policy_id, policy: true

    def reviewable_answers
      {}
    end
  end
end
