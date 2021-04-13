# frozen_string_literal: true

module Wizard::Steps
  class HasChangedName < Wizard::Step
    attribute :has_changed_name, :boolean

    validates :has_changed_name, inclusion: { in: [true, false] }

    def reviewable_answers
      {}
    end

    def skipped?
      @store.wizard(:teacher_ref_number)
    end
  end
end
