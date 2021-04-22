# frozen_string_literal: true

require "rails_helper"

def get_participant_emails_from_body(body)
  json = JSON.parse(body)["data"]
  json.map { |participant| participant["attributes"]["email"] }
rescue JSON::ParserError
  []
end

describe "Participants API", type: :request do
  include ActiveJob::TestHelper

  describe "GET index" do
    let(:credentials) do
      ActionController::HttpAuthentication::Token
        .encode_credentials("bats")
    end

    let(:unauthorized_credentials) do
      ActionController::HttpAuthentication::Token
        .encode_credentials("foo")
    end

    let(:get_index) { get "/api/v1/participants", headers: { "HTTP_AUTHORIZATION" => credentials } }

    context "without updated_since parameter" do
      before do
        Timecop.freeze(60.minutes.ago) do
          perform_enqueued_jobs do
            user = create(:user, full_name: "user one",
                                 email: "user.one@example.com")
            create(:early_career_teacher_profile, user: user)
          end
        end

        Timecop.freeze(30.minutes.ago) do
          perform_enqueued_jobs do
            user_2 = create(:user, full_name: "user two",
                                   email: "user.two@example.com")
            create(:early_career_teacher_profile, user: user_2)
          end
        end

        get_index
      end

      after do
        clear_enqueued_jobs
        clear_performed_jobs
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      xit "returns http unauthorised" do
        get "/api/v1/participants",
            headers: { "HTTP_AUTHORIZATION" => unauthorized_credentials }
        expect(response).to have_http_status(:unauthorized)
      end

      it "JSON body response contains expected participant attributes in correct order" do
        json = JSON.parse(response.body, symbolize_names: true)
        resources = json[:data].map { |resource| resource[:attributes] }
        expect(resources).to match [
          {
            full_name: "user one",
            email: "user.one@example.com",
          },
          {
            full_name: "user two",
            email: "user.two@example.com",
          },
        ]
      end
    end

    context "with updated_since parameter" do
      describe "JSON body response" do
        it "contains expected participants" do
          old_user = nil
          updated_user = nil

          Timecop.freeze(3.minutes.ago) do
            old_user = create(:user, full_name: Faker::Name.name,
                                     email: Faker::Internet.email)
            create(:early_career_teacher_profile, user: old_user)
          end

          Timecop.freeze(1.minute.ago) do
            updated_user = create(:user, full_name: Faker::Name.name,
                                         email: Faker::Internet.email)
            create(:early_career_teacher_profile, user: updated_user)
          end

          get "/api/v1/participants",
              headers: { "HTTP_AUTHORIZATION" => credentials },
              params: { updated_since: 2.minutes.ago.utc.iso8601 }

          returned_participant_emails = get_participant_emails_from_body(response.body)

          expect(returned_participant_emails).not_to include old_user.email
          expect(returned_participant_emails).to include updated_user.email
        end
      end

      def get_next_participants(body, params = {})
        link = JSON.parse(body, symbolize_names: true)[:links][:next]
        get link,
            headers: {
              "HTTP_AUTHORIZATION" => credentials,
            },
            params: params
      end

      context "with many participants" do
        before do
          @participants = Array.new(25) do |i|
            Timecop.freeze((30 - i).minutes.ago) do
              user = create(:user, full_name: Faker::Name.name,
                                   email: Faker::Internet.email)
              create(:early_career_teacher_profile, user: user)
            end
          end
        end

        it "pages properly" do
          participant_emails = @participants.map { |participant| participant.user.email }

          get_next_participants '{ "links": { "next": "/api/v1/participants" } }', per_page: 10
          expect(get_participant_emails_from_body(response.body))
            .to match_array participant_emails[0..9]

          get_next_participants response.body
          expect(get_participant_emails_from_body(response.body))
            .to match_array participant_emails[10..19]

          get_next_participants response.body
          expect(get_participant_emails_from_body(response.body))
            .to match_array participant_emails[20..24]
        end
      end

      context "with many participants updated in the same second" do
        timestamp = 1.second.ago
        before do
          @participants = Array.new(25) do |i|
            Timecop.freeze(timestamp + i / 1000.0) do
              user = create(:user, full_name: Faker::Name.name,
                                   email: Faker::Internet.email)
              create(:early_career_teacher_profile, user: user)
            end
          end
        end

        it "pages properly" do
          participant_emails = @participants.map { |participant| participant.user.email }

          get_next_participants '{ "links": { "next": "/api/v1/participants" } }', per_page: 10
          expect(get_participant_emails_from_body(response.body))
            .to match_array participant_emails[0..9]

          get_next_participants response.body
          expect(get_participant_emails_from_body(response.body))
            .to match_array participant_emails[10..19]

          get_next_participants response.body
          expect(get_participant_emails_from_body(response.body))
            .to match_array participant_emails[20..24]
        end
      end
    end
  end
end
