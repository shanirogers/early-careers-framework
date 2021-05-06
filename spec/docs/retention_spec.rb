require "swagger_helper"

RSpec.describe "api/payments/v1/retention", type: :request do
  path "/api/payments/v1/retention" do
    get("get retention") do
      response(200, "successful") do
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end
  end
end
