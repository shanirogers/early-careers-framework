# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include Pagy::Backend
      include ErrorHandlers::Pagy
      include PagyPagination
    end
  end
end
