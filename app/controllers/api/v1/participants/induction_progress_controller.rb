# frozen_string_literal: true

module Api
  module V1
    module Participants
      class InductionProgressController < Api::ApiController
        include LeadProviderAuthenticatable
        alias_method :current_user, :current_lead_provider
        before_action :set_paper_trail_whodunnit

        def create
          return head :not_found unless params[:id]

          user = User.find(params[:id])
          early_career_teacher = user.early_career_teacher_profile
          InductParticipant.call(early_career_teacher)
          head :no_content
        end
      end
    end
  end
end
