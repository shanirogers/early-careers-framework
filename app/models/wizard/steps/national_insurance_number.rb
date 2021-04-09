# frozen_string_literal: true

module Wizard::Steps
  class NationalInsuranceNumber < Wizard::Step
    attribute :national_insurance_number, :string

    validates :national_insurance_number, presence: true, length: { maximum: 13 }
  end
end
