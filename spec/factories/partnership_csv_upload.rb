# frozen_string_literal: true

FactoryBot.define do
  factory :partnership_csv_upload do
    lead_provider

    trait :with_csv do
      after(:build) do |partnership_csv_upload|
        partnership_csv_upload.csv.attach(io: File.open(Rails.root.join("spec/fixtures/files/school_urns.csv")), filename: "school_urns.csv", content_type: "text/csv")
      end
    end
  end
end
