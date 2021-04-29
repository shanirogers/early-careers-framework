# frozen_string_literal: true

module LeadProviders
  class PartnershipCsvUploadsController < ::LeadProviders::BaseController
    def new
      @partnership_csv_upload = PartnershipCsvUpload.new
    end

    def create
      # byebug
      if params[:partnership_csv_upload].blank?
        @partnership_csv_upload = PartnershipCsvUpload.new
        @partnership_csv_upload.errors[:base] << "Please select a CSV file to upload."
        render :new and return
      end

      @partnership_csv_upload = PartnershipCsvUpload.new(upload_params.merge(lead_provider_id: current_user.id))

      if @partnership_csv_upload.save
        redirect_to error_page_lead_providers_partnership_csv_uploads_path
      else
        render :new
      end
    end

    def error_page; end

  private

    def upload_params
      params.require(:partnership_csv_upload).permit(:lead_provider_id, :csv)
    end
  end
end
