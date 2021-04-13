# frozen_string_literal: true

module Wizard::Steps
  class DoNotKnowTrn < Wizard::Step
    def skipped?
      @store["has_teacher_ref_number"]
    end

    def can_proceed?
      false
    end
  end
end
