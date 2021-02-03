# frozen_string_literal: true

class CoreInductionProgramme < ApplicationRecord
  has_many :course_years, dependent: :delete_all
  has_many :early_career_teacher_profiles
  has_many :early_career_teachers, through: :early_career_teacher_profiles, source: :user
end
