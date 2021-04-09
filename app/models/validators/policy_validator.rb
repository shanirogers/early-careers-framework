# frozen_string_literal: true

class PolicyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      policy = 1 if value.present?
    end

    unless policy
      record.errors.add(attribute, :invalid_policy)
    end
  end
end
