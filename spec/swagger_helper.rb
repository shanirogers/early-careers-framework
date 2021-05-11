# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  config.swagger_root = Rails.root.join("swagger").to_s
  config.swagger_docs = {
    "v1/api_spec.json" => {
      swagger: "2.0",
      info: {
        title: "API documentation",
        version: "v1",
        description: "Auto generated document, run `bundle exec rake rswag` to regenerate",
        definitions: Dir[Rails.root.join("spec/docs/schemas/*.yaml")]
                        .map { |f| { File.basename(f, ".yaml").titleize.gsub(/\W+/, "") => YAML.safe_load(File.read(f)) } }
                        .reduce(&:merge),
      },
      basePath: "/api/v1",
      components: {
        securitySchemes: {
          bearer: {
            description: "Lead Provider token",
            type: :apiKey,
            name: "Authorization",
            in: :header,
          },

        },
      },
    },
  }

  config.swagger_format = :json
end
