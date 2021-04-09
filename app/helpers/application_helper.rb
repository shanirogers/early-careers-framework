# frozen_string_literal: true

module ApplicationHelper
  def profile_dashboard_url(user)
    if user.admin?
      admin_suppliers_url
    elsif user.induction_coordinator?
      induction_coordinator_dashboard_url(user)
    else
      dashboard_url
    end
  end

  def govuk_form_for(*args, **options, &block)
    merged = options.dup
    merged[:builder] = GOVUKDesignSystemFormBuilder::FormBuilder
    merged[:html] ||= {}
    merged[:html][:novalidate] = true

    form_for(*args, **merged, &block)
  end

  def back_link(path = :back, text: "Back", **options)
    options[:class] = "govuk-back-link #{options[:class]}".strip

    link_to text, path, **options
  end

  def link_to_change_answer(step)
    link_to(demos_demo_one_path(step.key), { class: "govuk-link" }) do
      safe_html_format("Change <span class='visually-hidden'> #{step.key.humanize(capitalize: false)}</span>")
    end
  end

private

  def induction_coordinator_dashboard_url(user)
    school = user.induction_coordinator_profile.schools.first

    return schools_choose_programme_url unless school.chosen_programme?(Cohort.current)

    schools_dashboard_url
  end
end
