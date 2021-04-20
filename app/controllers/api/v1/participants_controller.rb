# frozen_string_literal: true

module Api
  module V1
    class ParticipantsController < Api::V1::ApplicationController
      def index
        render jsonapi: paginate(participants),
               include: params[:include],
               class: Api::V1::SerializerService.call, fields: fields
      end

      def show
        uuid = params.fetch(:id, params[:participant_id])
        participant = EarlyCareerTeacherProfile.find(uuid)

        render jsonapi: participant,
               class: Api::V1::SerializerService.call,
               include: params[:include],
               fields: fields
      end

    private

      def updated_since
        @updated_since ||= params.dig(:filter, :updated_since)
      end

      def participants
        @participants = EarlyCareerTeacherProfile
        @participants = if sort_by_participant_ascending?
                          @participants.by_name_ascending
                        else
                          @participants.by_name_descending
                        end

        if updated_since.present?
          @participants = @participants.changed_since(updated_since)
        end

        @participants
      end

      def fields
        { participants: participant_fields } if participant_fields.present?
      end

      def sort_by_participant_ascending?
        sort_field.include?("name") || !sort_by_participant_descending?
      end

      def sort_by_participant_descending?
        sort_field.include?("-name")
      end

      def sort_field
        @sort_field ||= Set.new(params.dig(:sort)&.split(","))
      end

      def participant_fields
        params.dig(:fields, :participants)&.split(",")
      end
    end
  end
end
