# frozen_string_literal: true

class Api::V1::BaseController < Api::ApiController
  before_action :set_jsonapi_content_type_header

private

  def set_jsonapi_content_type_header
    headers["Content-Type"] = "application/vnd.api+json"
  end
end
