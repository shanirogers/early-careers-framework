# frozen_string_literal: true

class ParticipantProfile < ApplicationRecord
  has_paper_trail versions: {
    class_name: "ParticipantEvent",
  }
  belongs_to :early_career_teacher_profile

  include AASM

  aasm column: :state

  aasm do
    state :assigned, initial: true
    state :active, :deferred, :withdrawn, :completed
    before_all_events :before_all_events

    event :join do
      transitions from: :assigned, to: :active
    end

    event :defer do
      transitions from: :active, to: :deferred
    end

    event :resume do
      transitions from: :deferred, to: :active
    end

    event :withdraw do
      transitions from: %i[active deferred], to: :withdrawn
    end

    event :complete do
      transitions from: :active, to: :completed
    end
  end

  def before_all_events
    self.paper_trail_event = aasm.current_event
  end

end
