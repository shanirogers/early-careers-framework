# frozen_string_literal: true

class Api::V1::ProviderEventsController < Api::V1::ApplicationController
  def create
    return head :no_content unless params[:id]

    user=User.find(params[id])
    early_career_teacher=user.early_career_teacher_profile
    return head :unprocessable_entity if @early_career_teacher.nil?
    ParticipantAddService(early_career_teacher)
    head :created
  end
end
