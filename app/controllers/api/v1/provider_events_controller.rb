# frozen_string_literal: true

class Api::V1::ProviderEventsController < Api::V1::ApplicationController
  def create
    return head :no_content unless params[:id]

    begin
      user = User.find(params[:id])
      early_career_teacher = user.early_career_teacher_profile
      ParticipantAddService.call(early_career_teacher)
      head :created
    rescue RecordNotFound
      head :unprocessable_entity
    end
  end
end
