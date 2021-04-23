# frozen_string_literal: true

class CookiesController < ApplicationController
  before_action :set_cookie_form, only: :show

  BACK_TO_SESSION_KEY = "_cookies_back_to"

  def show
    @backlink = recognize_back_path
  end

  def update
    analytics_consent = params[:cookies_form][:analytics_consent]
    if %w[on off].include?(analytics_consent)
      cookies[:cookie_consent_1] = { value: analytics_consent, expires: 1.year.from_now }
    end

    respond_to do |format|
      format.html do
        set_cookie_form
        set_success_message(content: "You’ve set your cookie preferences.", title: "Success")
        redirect_to cookies_path
      end

      format.json do
        render json: {
          status: "ok",
          message: %(You've #{analytics_consent == 'on' ? 'accepted' : 'rejected'} analytics cookies.),
        }
      end
    end
  end

private

  def recognize_back_path
    referer = Rails.application.routes.recognize_path(request.referer)
    if referer[:controller] == controller_name
      session[BACK_TO_SESSION_KEY]
    else
      session[BACK_TO_SESSION_KEY] = request.referer || root_path
    end
  rescue ActionController::RoutingError
    session[BACK_TO_SESSION_KEY] = request.referer
  end

  def set_cookie_form
    @cookies_form = CookiesForm.new(analytics_consent: cookies[:cookie_consent_1])
  end
end
