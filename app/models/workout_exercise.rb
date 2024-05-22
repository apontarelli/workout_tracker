class WorkoutExercise < ApplicationRecord
    belongs_to :workout
    belongs_to :exercisable, polymorphic: true
    has_many :workout_sets, dependent: :destroy
    accepts_nested_attributes_for :workout_sets, allow_destroy: true

    attr_accessor :combined_exercise_id

    before_validation :set_exercisable

    def set_exercisable
        if combined_exercise_id.present?
            type, id = combined_exercise_id.split('-')
            self.exercisable_type = type
            self.exercisable_id = id
        end
    end
end
