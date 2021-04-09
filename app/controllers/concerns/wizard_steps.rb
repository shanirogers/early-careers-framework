# frozen_string_literal: true

module WizardSteps
  extend ActiveSupport::Concern

  included do
    class_attribute :wizard_class
    before_action :load_wizard, :load_current_step, only: %i[show update]
  end

  def index
    redirect_to step_path(wizard_class.first_key)
  end

  def show
    # current_step loaded via before_action
  end

  def update
    @current_step.assign_attributes step_params

    if @current_step.save!
      redirect_to next_step_path

      # Needs to occur after redirect because it purges data after submission
      @wizard.complete!
    end
  end

  def completed
    # current_step is loaded via before_action
  end

private

  def load_wizard
    @wizard = wizard_class.new(wizard_store, params[:id])
  rescue Wizard::UnknownStep
    raise_not_found
  end

  def load_current_step
    @current_step = @wizard.find_current_step
  end

  def next_step_path
    if (next_key = @wizard.next_key)
      step_path next_key
    elsif (exit_step = @wizard.first_exit_step)
      step_path exit_step
    elsif (invalid_step = @wizard.first_invalid_step)
      step_path invalid_step
    else # all demo_one valid so completed
      step_path :completed
    end
  end

  def authenticate_path(params = {})
    step_path :authenticate, params
  end

  def step_params
    return {} unless params.key?(step_param_key)

    params.require(step_param_key).permit @current_step.attributes.keys
  end

  def step_param_key
    @current_step.class.model_name.param_key
  end

  def camelized_identity_data
    Wizard::Steps::Authenticate.new(nil, wizard_store)
      .candidate_identity_data
  end
end
