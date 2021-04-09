# frozen_string_literal: true

module Demos
  class DemoTwo < ::Wizard::Base
    include ::Wizard::ApiClientSupport

    self.steps = [
      ::Wizard::Steps::Identity,
      ::Wizard::Steps::HasTeacherId,
      ::Wizard::Steps::TeacherId,
      ::Wizard::Steps::DateOfBirth,
      ::Wizard::Steps::ReviewAnswers,
      ::Wizard::Steps::AcceptPrivacyPolicy,
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
