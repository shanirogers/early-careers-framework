# frozen_string_literal: true

require "rails_helper"

describe "Payments API", type: :request do
  describe "retention data" do
    let(:parsed_response) { JSON.parse(response.body) }

    it "returns a draft number" do
      get "/api/payments/v1/retention"
      expect(response.status).to eq 200
      expect(parsed_response["total_retained"]).to eq(3)
    end
  end
end
