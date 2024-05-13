class WorkoutExercise < ApplicationRecord
    belongs_to :workout
    belongs_to :exercisable, polymorphic: true
end
