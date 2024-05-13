class Exercise < ApplicationRecord
    has_many :workout_exercises, as: :exercisable
    has_many :template_exercises, as: :exercisable
end
