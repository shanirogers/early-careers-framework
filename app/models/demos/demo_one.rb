# frozen_string_literal: true

module Demos
  class DemoOne < ::Wizard::Base
    include ::Wizard::ApiClientSupport

    self.steps = [
      ::Wizard::Steps::CanShareChoices,
      ::Wizard::Steps::HasTeacherRefNumber,
      ::Wizard::Steps::DoNotKnowTrn,
      ::Wizard::Steps::HasChangedName,
      ::Wizard::Steps::HasUpdatedDqtName,
      ::Wizard::Steps::UnsureOfDqtName,
      ::Wizard::Steps::NotUpdatedDqtName,
      ::Wizard::Steps::ChangeDqtName,
      ::Wizard::Steps::QualifiedTeacherCheck,
      ::Wizard::Steps::ContactDetails,
      ::Wizard::Steps::VerifyContactDetails,
      ::Wizard::Steps::ChooseNpq,
      ::Wizard::Steps::ChooseProvider,
      ::Wizard::Steps::ConfirmSchool,
      ::Wizard::Steps::ChooseSchool,
      ::Wizard::Steps::ReviewAnswers,
    ].freeze

    def time_zone
      "London"
    end

    def complete!
      super.tap do |result|
        break unless result

        request_npq_training
        @store.purge!
      end
    end

  private

    def request_npq_training
      # action to perform once wizard demo_one are complete
    end
  end
end
