# frozen_string_literal: true

module Wizard::Steps
  class QualifiedTeacherCheck < Wizard::Step
    # multi parameter date fields aren't yet support by ActiveModel so we
    # need to include the support for them from ActiveRecord
    require "active_record/attribute_assignment"
    include ::ActiveRecord::AttributeAssignment

    MIN_AGE = 18
    MAX_AGE = 70

    attribute :teacher_ref_number, :string
    attribute :first_name, :string
    attribute :last_name, :string
    attribute :date_of_birth, :date
    attribute :national_insurance_number, :string

    validates :teacher_ref_number, presence: true, format: { with: /\A([0-9])*\z/ }, length: { maximum: 7 }
    validates :first_name, presence: true, length: { maximum: 256 }
    validates :last_name, presence: true, length: { maximum: 256 }
    validates :date_of_birth, presence: true
    validates :national_insurance_number, presence: true, length: { maximum: 13 }

    before_validation :sanitize_input
    before_validation :date_of_birth, :add_invalid_error

    def self.contains_personal_details?
      true
    end

    def reviewable_answers
      super
        .tap { |answers|
          answers["name"] = "#{answers['first_name']} #{answers['last_name']}"
          answers["date_of_birth"] = date_of_birth
        }
        .without("first_name", "last_name")
    end

    # Rescue argument error thrown by
    # validates_timeliness/extensions/multiparameter_handler.rb
    # when the user enters a DOB like `-1, -1, -2`.
    # date of birth will be unset and a custom error message later added
    def date_of_birth=(value)
      @date_of_birth_invalid = false
      super
    rescue ArgumentError
      @date_of_birth_invalid = true
      nil
    end

    def skipped?
      return true if super

      has_teacher_ref_number_step = other_step(:has_teacher_ref_number)
      has_teacher_ref_number_skipped = has_teacher_ref_number_step.skipped?
      has_teacher_ref_number = has_teacher_ref_number_step.has_teacher_ref_number

      has_teacher_ref_number_skipped || !has_teacher_ref_number
    end

  private

    def add_invalid_error
      errors.add(:date_of_birth, :invalid) if @date_of_birth_invalid
    end

    def sanitize_input
      self.first_name = first_name.to_s.strip.presence if first_name
      self.last_name = last_name.to_s.strip.presence if last_name
    end
  end
end
