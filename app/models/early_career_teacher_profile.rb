# frozen_string_literal: true

class EarlyCareerTeacherProfile < ApplicationRecord
  belongs_to :user
  belongs_to :school
  belongs_to :core_induction_programme, optional: true
  belongs_to :cohort, optional: true

  scope :changed_since, lambda { |timestamp|
    if timestamp.present?
      where("early_career_teacher_profile.changed_at > ?", timestamp)
    else
      where("changed_at is not null")
    end.order(:changed_at, :id)
  }

  scope :by_name_ascending, -> { order(full_name: :asc) }
  scope :by_name_descending, -> { order(full_name: :desc) }

private

  def full_name
    user.full_name
  end
end
