class Workout < ApplicationRecord
    belongs_to :user
    belongs_to :program, optional: true
    has_many :workout_exercises
end
