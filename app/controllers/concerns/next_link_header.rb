# frozen_string_literal: true

module NextLinkHeader
  extend ActiveSupport::Concern
  include TimeFormat

private

  def set_next_link_header_using_updated_since_or_last_object(last_object,
                                                              params = {})
    next_url_params = {}
    next_url_params[:updated_since] = params[:updated_since]
    next_url_params[:per_page] = params[:per_page]

    if last_object.present?
      next_url_params[:updated_since] = precise_time(last_object.updated_at)
    end

    response.headers["Link"] = "#{url_for(params: next_url_params)}; rel=\"next\""
  end
end
