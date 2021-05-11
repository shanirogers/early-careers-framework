# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  config.swagger_root = Rails.root.join("swagger").to_s
  config.swagger_docs = {
    "v1/api_spec.json" => {
      openapi: "3.0.1",
      info: {
        title: "API documentation",
        version: "v1",
        description: "Auto generated document, run `bundle exec rake rswag` to regenerate",
      },
      components: {
        securitySchemes: {
          bearerAuth: {
            bearerFormat: "string",
            type: "http",
            scheme: "bearer",
          },
        },
      },
      security: [
        bearerAuth: [],
      ],
      servers: [
        {
          url: "https://{defaultHost}/api/{version}",
          variables: {
            defaultHost: {
              default: "ecf-dev.london.cloudapps.digital",
            },
            version: {
              enum: %w[
                v1
              ],
              default: "v1",
            },
          },
        },
      ],
    },
    "public_v1/api_spec.json" => {
      openapi: "3.0.1",
      info: {
        title: "API documentation",
        version: "v1",
        description: "Auto generated document, run `bundle exec rake rswag` to regenerate",
      },
      servers: [
        {
          url: "https://{defaultHost}/api/public/{version}",
          variables: {
            defaultHost: {
              default: "ecf-dev.london.cloudapps.digital",
            },
            version: {
              enum: %w[
                v1
              ],
              default: "v1",
            },
          },
        },
      ],
    },
  }
  config.swagger_format = :json
end
