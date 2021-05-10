# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Early Career Teacher Participants", type: :request do
  describe "early-career-teacher-participants" do
    let(:lead_provider) { create(:lead_provider) }
    let(:token) { LeadProviderApiToken.create_with_random_token!(lead_provider: lead_provider) }
    let(:bearer_token) { "Bearer #{token}" }
    let(:payload) { create(:early_career_teacher_profile) }

    let(:parsed_response) { JSON.parse(response.body) }

    context "when authorized" do
      before do
        default_headers[:Authorization] = bearer_token
      end

      it "returns 204 when passed no content" do
        post "/api/v1/early-career-teacher-participants", params: {}
        expect(response.status).to eq 204
      end

      it "returns 201-created status" do
        post "/api/v1/early-career-teacher-participants", params: { id: payload.user_id }
        expect(response.status).to eq 201
      end

      it "returns 422-unprocessable-entity status for incorrect params" do # Expectes the user uuid. Pass the early_career_teacher_profile_id
        post "/api/v1/early-career-teacher-participants", params: { id: payload.id }
        expect(response.status).to eq 422
      end
    end

    context "when unauthorized" do
      it "returns 401 for invalid bearer token" do
        default_headers[:Authorization] = "Bearer: ugLPicDrpGZdD_w7hhCL"
        post "/api/v1/early-career-teacher-participants", params: { id: payload.user_id }
        expect(response.status).to eq 401
      end
    end
  end
end
