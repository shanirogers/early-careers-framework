# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    include Pundit
  end
end
