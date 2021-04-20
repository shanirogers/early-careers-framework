# frozen_string_literal: true

module Api
  module V1
    class SerializerService
      include ServicePattern

      def call
        {
          EarlyCareerTeacherProfile: Api::V1::SerializableEarlyCareerTeacherProfile,
        }
      end
    end
  end
end
