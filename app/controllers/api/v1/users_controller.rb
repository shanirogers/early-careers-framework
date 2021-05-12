# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def index
        render json: UserSerializer.new(User.all).serializable_hash.to_json
      end
    end
  end
end
