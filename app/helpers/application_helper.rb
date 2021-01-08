# frozen_string_literal: true

module ApplicationHelper
  def profile_dashboard_url(user)
    if user.admin_profile
      admin_dashboard_url
    else
      dashboard_url
    end
  end
end
