# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ApplicationController, type: :controller do
  describe "#authenticate" do
    before do
      controller.response              = response
      request.headers["Authorization"] = bearer_token
      controller.authenticate
    end

    context "when authorization header not provided or invalid" do
      let(:bearer_token) { "Bearer invalid" }

      it "requests authentication via the http header" do
        expect(response.status).to eq(401)
      end
    end

    context "when authorization header is provided" do
      let(:bearer_token) { "Bearer tnp" }

      it "requests authentication via the http header" do
        expect(response.status).to eq(200)
      end
    end
  end
end
