# frozen_string_literal: true

class EarlyCareerTeacherProfile < ApplicationRecord
  belongs_to :user
  belongs_to :school
  belongs_to :core_induction_programme, optional: true
  belongs_to :cohort, optional: true

  scope :updated_since, lambda { |timestamp|
    if timestamp.present?
      where("updated_at > ? or created_at > ?", timestamp, timestamp)
    else
      where("updated_at is not null or created_at is not null")
    end.order(:updated_at || :created_at)
  }

  scope :by_name_ascending, -> { includes(:user).order("users.full_name ASC") }
  scope :by_name_descending, -> { includes(:user).order("users.full_name DESC") }
end
