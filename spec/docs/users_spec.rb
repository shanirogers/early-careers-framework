# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "API", type: :request do
  path "/users" do
    get "Returns all users" do
      operationId :public_api_v1_user_index
      tags "user"
      produces "application/vnd.api+json"

      response "200", "Collection of users." do
        schema type: :object,
               required: %w[data],
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     required: %w[id type attributes],
                     properties: {
                       id: { type: :string },
                       type: { type: :string },
                       attributes: {
                         type: :object,
                         required: %w[email full_name],
                         properties: {
                           email: { type: :string },
                           full_name: { type: :string },
                         },
                       },
                     },
                   },
                 },
               }

        run_test!
      end
    end
  end
end
