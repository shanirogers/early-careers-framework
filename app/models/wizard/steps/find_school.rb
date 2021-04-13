# frozen_string_literal: true

module Wizard::Steps
  class FindSchool < Wizard::Step
    def can_proceed?
      false
    end
  end
end
