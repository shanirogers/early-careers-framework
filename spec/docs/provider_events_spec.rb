# frozen_string_literal: true

=begin
require "swagger_helper"

RSpec.describe "Early Career Teacher Participation", type: :request do
  path "/early-career-teacher-participation" do
    post "Create provider event" do
      operationId :api_v1_create_ect_participant
      tags "provider events"
      response 422, "unprocessable_entity" do
        let(:id) { "1234567890" }
        run_test!
      end

    end
  end
end
=end
