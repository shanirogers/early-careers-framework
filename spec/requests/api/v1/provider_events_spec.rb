# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API Provider Events", type: :request do
  describe "provider_events" do
    let(:lead_provider) { create(:lead_provider) }
    let(:token) { LeadProviderApiToken.create_with_random_token!(lead_provider: lead_provider) }

    let(:parsed_response) { JSON.parse(response.body) }

    it "returns 201-created status" do
      post "/api/v1/provider-events", params: {}, headers: { "Authorization": "Bearer #{token}" }
      expect(response.status).to eq 201
    end

    xit "returns 422-unprocessable-entity status for missing params" do
      post "/api/v1/provider-events"
      expect(response.status).to eq 422
    end
  end
end
