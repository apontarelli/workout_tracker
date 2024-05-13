class TemplateExercise < ApplicationRecord
    belongs_to :workout_template
    belongs_to :exercisable, polymorphic: true
end
