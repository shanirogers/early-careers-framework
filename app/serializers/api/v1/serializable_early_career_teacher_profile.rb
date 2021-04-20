# frozen_string_literal: true

module Api
  module V1
    class SerializableEarlyCareerTeacherProfile < JSONAPI::Serializable::Resource
      type "early_career_teacher_profile"

      attribute :name do
        @object.user.full_name
      end

      attribute :email do
        @object.user.email
      end
    end
  end
end
