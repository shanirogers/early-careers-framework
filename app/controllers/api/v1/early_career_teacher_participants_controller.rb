# frozen_string_literal: true

module Api
  module V1
    class EarlyCareerTeacherParticipantsController < Api::ApiController
      include LeadProviderAuthenticatable

      def create
        return head :no_content unless params[:id]

        begin
          user = User.find(params[:id])
          early_career_teacher = user.early_career_teacher_profile
          ParticipantAddService.call(early_career_teacher)
          head :created
        rescue ActiveRecord::RecordNotFound
          head :unprocessable_entity
        end
      end
    end
  end
end
