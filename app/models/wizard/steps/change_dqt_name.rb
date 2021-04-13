# frozen_string_literal: true

module Wizard::Steps
  class ChangeDqtName < Wizard::Step
    def skipped?
      @store["not_updated_dqt_name"] != "change_name"
    end

    def can_proceed?
      false
    end
  end
end
