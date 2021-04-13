# frozen_string_literal: true

module Wizard::Steps
  class HasTeacherRefNumber < Wizard::Step
    attribute :has_teacher_ref_number, :boolean

    validates :has_teacher_ref_number, inclusion: { in: [true, false] }

    def reviewable_answers
      super.tap do |answers|
        answers["has_teacher_ref_number"] = has_teacher_ref_number ? "Yes" : "No"
      end
    end

    def skipped?
      @store.wizard(:teacher_id)
    end
  end
end
