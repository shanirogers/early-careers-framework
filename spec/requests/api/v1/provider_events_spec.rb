# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API Provider Events", type: :request do
  describe "provider-events" do
    let(:lead_provider) { create(:lead_provider) }
    let(:token) { LeadProviderApiToken.create_with_random_token!(lead_provider: lead_provider) }
    let(:payload) { create(:early_career_teacher_profile)}

    let(:parsed_response) { JSON.parse(response.body) }

    it "returns 204 when passed no content" do
      post "/api/provider-events", params: {}, headers: {"Authorization": "Bearer #{token}", "Accept": "application/vnd.dfe.gov.uk.v1"}
      expect(response.status).to eq 204
    end

    it "returns 201-created status" do
      post "/api/provider-events", params: { id: payload.user_id }, headers: {"Authorization": "Bearer #{token}", "Accept": "application/vnd.dfe.gov.uk.v1"}
      expect(response.status).to eq 201
    end

    it "returns 422-unprocessable-entity status for incorrect params" do #Expectes the user uuid. Pass the early_career_teacher_profile_id
      post "/api/provider-events", params: { id: payload.id }, headers: {"Authorization": "Bearer #{token}", "Accept": "application/vnd.dfe.gov.uk.v1"}
      expect(response.status).to eq 422
    end
  end
end
