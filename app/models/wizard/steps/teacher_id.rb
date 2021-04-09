# frozen_string_literal: true

module Wizard::Steps
  class TeacherId < Wizard::Step
    attribute :teacher_id, :string

    validates :teacher_id, presence: true, format: { with: /\A([0-9])*\z/ }, length: { maximum: 7 }

    def skipped?
      return true if super

      has_teacher_id_step = other_step(:has_teacher_id)
      has_teacher_id_skipped = has_teacher_id_step.skipped?
      has_id = has_teacher_id_step.has_id

      has_teacher_id_skipped || !has_id
    end
  end
end
