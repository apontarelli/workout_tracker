class WorkoutTemplate < ApplicationRecord
    belongs_to :program, optional:true
    belongs_to :user
    has_many :template_exercises
    has_many :exercises, through: :template_exercises, source: :exercisable, source_type: 'Exercise'
    has_many :user_exercises, through: :template_exercises, source: :exercisable, source_type: 'UserExercise'
end
