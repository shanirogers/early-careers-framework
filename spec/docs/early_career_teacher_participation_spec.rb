# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Early Career Teacher Participation", type: :request do
  let(:user) { create(:user) }
  let(:lead_provider) { create(:lead_provider) }
  let(:token) { LeadProviderApiToken.create_with_random_token!(lead_provider: lead_provider) }
  let(:bearer_token) { "Bearer #{token}" }

  before do
    default_headers[:Authorization] = bearer_token
  end

  path "/early-career-teacher-participants" do
    post "Add Early Career Teacher to Course" do
      operationId :api_v1_create_ect_participant
      tags "ect_participant"
      consumes "application/json"
      parameter name: "Authorization", in: :header, required: false, type: :string, description: "The bearer token associated with a lead provider"
      parameter name: :params, in: :body, required: false, type: :string, description: "The unique id of the participant"

      response 201, "Successful" do
        let(:params) { { "id" => user.id } }
        run_test!
      end

      response "404", "Not Found" do
        run_test!
      end

      response "401", "Unauthorized" do
        let(:Authorization) { "Bearer invalid" }
        run_test!
      end
    end
  end
end
