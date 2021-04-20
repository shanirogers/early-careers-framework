# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    user
    school
  end
end
