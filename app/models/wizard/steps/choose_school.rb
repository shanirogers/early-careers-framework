# frozen_string_literal: true

module Wizard::Steps
  class ChooseSchool < Wizard::Step
    attribute :school_name, :string

    validates :school_name, presence: true, length: { maximum: 100 }

    def skipped
      !@store["confirm_school"]
    end
  end
end
