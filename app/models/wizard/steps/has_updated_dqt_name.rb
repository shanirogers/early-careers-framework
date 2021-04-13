# frozen_string_literal: true

module Wizard::Steps
  class HasUpdatedDqtName < Wizard::Step
    attribute :has_updated_dqt_name, :string

    validates :has_updated_dqt_name, inclusion: { in: %w[yes no not_sure] }

    def reviewable_answers
      super.tap do |answers|
        answers["has_updated_dqt_name"] = has_updated_dqt_name.to_s.capitalize
      end
    end

    def skipped?
      !@store["has_changed_name"]
    end
  end
end
