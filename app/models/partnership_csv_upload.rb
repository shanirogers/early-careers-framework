# frozen_string_literal: true

class PartnershipCsvUpload < ApplicationRecord
  has_one_attached :csv
  belongs_to :lead_provider, optional: true

  validate :csv_validation

  MAX_FILE_SIZE = 2.megabytes

private

  def csv_validation
    return unless csv.attached?

    if csv.content_type != "text/csv"
      errors[:base] << "File must be a CSV"
    end

    if csv.byte_size > MAX_FILE_SIZE
      errors[:base] << "File must be less than 2mb."
    end
  end
end
