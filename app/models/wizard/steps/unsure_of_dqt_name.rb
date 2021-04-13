# frozen_string_literal: true

module Wizard::Steps
  class UnsureOfDqtName < Wizard::Step
    def skipped?
      @store["has_updated_dqt_name"] != "not_sure"
    end

    def can_proceed?
      false
    end
  end
end
