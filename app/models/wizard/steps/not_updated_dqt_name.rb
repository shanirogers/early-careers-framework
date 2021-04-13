# frozen_string_literal: true

module Wizard::Steps
  class NotUpdatedDqtName < Wizard::Step
    attribute :not_updated_dqt_name, :string

    validates :not_updated_dqt_name, inclusion: { in: %w[change_name old_name] }

    def reviewable_answers
      super.tap do |answers|
        answers["not_updated_dqt_name"] = not_updated_dqt_name.to_s.capitalize
      end
    end

    def skipped?
      @store["has_updated_dqt_name"] == "yes"
    end
  end
end
