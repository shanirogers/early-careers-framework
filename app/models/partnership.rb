# frozen_string_literal: true

class Partnership < ApplicationRecord
  CHALLENGE_WINDOW = 14.days.freeze

  before_create :set_challenge_deadline

  enum challenge_reason: {
    another_provider: "another_provider",
    not_confirmed: "not_confirmed",
    do_not_recognise: "do_not_recognise",
    no_ects: "no_ects",
    mistake: "mistake",
  }

  belongs_to :school
  belongs_to :lead_provider
  belongs_to :cohort
  belongs_to :delivery_partner
  has_many :partnership_notification_emails

  has_paper_trail

  def challenged?
    challenge_reason.present?
  end

  scope :unchallenged, -> { where(challenged_at: nil, challenge_reason: nil) }

  def challenge!(reason)
    raise ArgumentError if reason.blank?

    update!(challenge_reason: reason, challenged_at: Time.zone.now)
  end

  def in_challenge_window?
    challenge_deadline > Time.zone.now
  end

private

  def set_challenge_deadline
    self.challenge_deadline ||= Time.zone.now + CHALLENGE_WINDOW
  end
end
