# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ApiController
      before_action :authenticate

      def authenticate
        authenticate_or_request_with_http_token do |unhashed_token|
          @current_lead_provider_api_token = LeadProviderApiToken.find_by_unhashed_token(unhashed_token)
          @current_lead_provider_api_token.update!(
            last_used_at: Time.zone.now,
          ) if @current_lead_provider_api_token
        end
      end

      def current_provider
        @current_lead_provider ||= @current_lead_provider_api_token&.lead_provider
      end
    end
  end
end
