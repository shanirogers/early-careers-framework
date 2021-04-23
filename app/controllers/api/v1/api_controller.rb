# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include Pundit

      include Pagy::Backend
      include ErrorHandlers::Pagy
      include PagyPagination

      # child must define authenticate method
      before_action :authenticate
      after_action :verify_authorized

      def authenticate
        authenticate_or_request_with_http_token do |token|
          ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.config.authentication_token)
        end
      end
    end
  end
end
