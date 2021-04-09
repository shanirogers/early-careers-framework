# frozen_string_literal: true

module Wizard::Steps
  class HasTeacherId < Wizard::Step
    attribute :has_id, :boolean

    validates :has_id, inclusion: { in: [true, false] }

    def reviewable_answers
      super.tap do |answers|
        answers["has_id"] = has_id ? "Yes" : "No"
      end
    end

    def skipped?
      @store.crm(:teacher_id)
    end
  end
end
