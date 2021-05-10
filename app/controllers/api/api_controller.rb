# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Pundit
  end
end
