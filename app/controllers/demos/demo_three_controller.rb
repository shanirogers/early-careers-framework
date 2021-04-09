# frozen_string_literal: true

module Demos
  class DemoThreeController < ApplicationController
    include CircuitBreaker
    include WizardSteps
    self.wizard_class = Demos::DemoThree

    around_action :set_time_zone, only: [:show] # rubocop:disable Rails/LexicallyScopedActionFilter
    before_action :set_page_title, only: [:show] # rubocop:disable Rails/LexicallyScopedActionFilter

  protected

    def not_available_path
      demos_not_available_path
    end

  private

    def set_time_zone
      old_time_zone = Time.zone
      Time.zone = @wizard.time_zone
      yield
    ensure
      Time.zone = old_time_zone
    end

    def step_path(step = params[:id], params = {})
      demos_demo_three_path step, params
    end
    helper_method :step_path

    def wizard_store
      ::Wizard::Store.new app_store, crm_store
    end

    def app_store
      session[:sign_up] ||= {}
    end

    def crm_store
      session[:sign_up_crm] ||= {}
    end

    def set_page_title
      @page_title = "#{@current_step.title.downcase} step"
    end
  end
end
