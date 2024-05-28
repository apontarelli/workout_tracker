class TemplateExercise < ApplicationRecord
  # Associations
  belongs_to :workout_template
  belongs_to :exercisable, polymorphic: true
end
