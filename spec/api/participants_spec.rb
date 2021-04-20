# frozen_string_literal: true

require "swagger_helper"

describe "API" do
  path "/participants" do
    get "Returns participants for the specified Lead Provider." do
      operationId :api_v1_participant_index
      tags "participant"
      produces "application/json"
      parameter name: :sort,
                in: :query,
                schema: { "$ref" => "#/components/schemas/Sort" },
                style: :form,
                explode: false,
                required: false,
                example: "name",
                description: "Field(s) to sort the participants by."
      parameter name: :filter,
                in: :query,
                schema: { "$ref" => "#/components/schemas/ParticipantFilter" },
                style: :deepObject,
                explode: true,
                required: false,
                description: "Refine participants to return.",
                example: { updated_since: "2020-11-13T11:21:55Z" }
      parameter name: :page,
                in: :query,
                schema: { "$ref" => "#/components/schemas/Pagination" },
                style: :deepObject,
                explode: true,
                required: false,
                example: { page: 2, per_page: 10 },
                description: "Pagination options to navigate through the collection."

      curl_example description: "Get all participants",
                   command: "curl -X GET https://api-manage-teachers-professional-development.education.gov.uk/api/v1/participants"

      curl_example description: "Get second page of participants",
                   command: "curl -X GET https://api-manage-teachers-professional-development.education.gov.uk/api/v1/participants?page[page]=2"

      response "200", "Collection of participants." do
        schema "$ref": "#/components/schemas/ParticipantListResponse"

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

  path "/participants/{participant_id}" do
    get "Returns the specified participant." do
      operationId :api_v1_participant_show
      tags "participant"
      produces "application/json"
      parameter name: :participant_id,
                in: :path,
                type: :string,
                required: true,
                description: "The unique code of the participant.",
                example: "T92"

      curl_example description: "Get a specific participant",
                   command: "curl -X GET https://api-manage-teachers-professional-development.education.gov.uk/api/v1/participants/B20"

      response "200", "The participant." do
        let(:participant) { create(:early_career_teacher_profile) }
        let(:participant_id) { participant.id }

        schema "$ref": "#/components/schemas/ParticipantSingleResponse"

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end

        run_test!
      end

      response "404", "The non existent participant." do
        let(:participant_id) { "999" }

        schema "$ref": "#/components/schemas/404ErrorResponse"

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
