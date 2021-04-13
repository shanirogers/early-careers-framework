# frozen_string_literal: true

module Wizard::Steps
  class ContactDetails < Wizard::Step
    attribute :email, :string

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { maximum: 100 }

    before_validation :sanitize_input

  private

    def sanitize_input
      self.email = email.to_s.strip.presence if email
    end
  end
end
