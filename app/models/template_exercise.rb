# frozen_string_literal: true

class TemplateExercise < ApplicationRecord
  # Attributes
  attr_accessor :combined_exercise_id

  # Associations
  belongs_to :template_workout
  belongs_to :exercisable, polymorphic: true
  has_many :template_sets, dependent: :destroy

  # Nested Attributes
  accepts_nested_attributes_for :template_sets, allow_destroy: true

  # Callbacks
  before_validation :set_exercisable

  # Class Methods
  def set_exercisable
    return if combined_exercise_id.blank?

    type, id = combined_exercise_id.split('-')
    self.exercisable_type = type
    self.exercisable_id = id
  end
end
