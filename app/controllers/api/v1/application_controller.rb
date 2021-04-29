# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ApiController
      before_action :authenticate

      def authenticate
        authenticate_or_request_with_http_token do |token|
          ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.config.authentication_token)
        end
      end
    end
  end
end
