# frozen_string_literal: true

class EarlyCareerTeacherProfileSerializer < ActiveModel::Serializer
  attributes :created_at, :changed_at

  def created_at
    object.created_at.iso8601
  end

  def changed_at
    object.changed_at.iso8601
  end
end
