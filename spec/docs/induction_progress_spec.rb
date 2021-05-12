# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Induction Progress", type: :request, swagger_doc: "v1/api_spec.json" do
  let(:user) { create(:user) }
  let(:lead_provider) { create(:lead_provider) }
  let(:token) { LeadProviderApiToken.create_with_random_token!(lead_provider: lead_provider) }
  let(:bearer_token) { "Bearer #{token}" }
  let(:Authorization) { bearer_token }

  path "/api/v1/induction-progress" do
    post "Submit induction progress for a participant" do
      operationId :api_v1_create_ect_participant
      tags "participant", "induction progress"
      consumes "application/json"
      security [bearerAuth: []]
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
