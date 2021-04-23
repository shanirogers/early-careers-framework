# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Cookies API", type: :request do
  describe "PUT /cookies" do
    it "handles analytics cookie acceptance" do
      headers = { "ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
      put "/cookies", params: { "cookies_form": { "analytics_consent": "on" } }.to_json, headers: headers

      expected = { status: "ok", message: "You've accepted analytics cookies." }.to_json
      expect(response.content_type).to include("application/json")
      expect(response.body).to eq(expected)
      expect(response.cookies["cookie_consent_1"]).to eq("on")
    end

    it "handles analytics cookie rejection" do
      headers = { "ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
      put "/cookies", params: { "cookies_form": { "analytics_consent": "off" } }.to_json, headers: headers

      expected = { status: "ok", message: "You've rejected analytics cookies." }.to_json
      expect(response.content_type).to include("application/json")
      expect(response.body).to eq(expected)
      expect(response.cookies["cookie_consent_1"]).to eq("off")
    end

    it "does not affect back link session variable" do
      get cookies_path, headers: { "HTTP_REFERER" => "/privacy-policy" }

      headers = { "ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
      put "/cookies", params: { "cookies_form": { "analytics_consent": "on" } }.to_json, headers: headers

      expect(back_link).to eq("/privacy-policy")
    end
  end

  describe "GET /cookies" do
    context "from a different internal page" do
      it "sets the back to session variable as previous url" do
        get cookies_path, headers: { "HTTP_REFERER" => "/privacy-policy" }
        expect(back_link).to eq("/privacy-policy")
      end
    end

    context "from the same controller with empty session" do
      it "sets the back link session variable as root url" do
        get cookies_path
        expect(back_link).to eq("/")
      end
    end
  end

  def back_link
    session[CookiesController::BACK_TO_SESSION_KEY]
  end
end
