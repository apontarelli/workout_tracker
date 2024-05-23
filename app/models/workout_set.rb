class WorkoutSet < ApplicationRecord
  belongs_to :workout_exercise
  validates :reps, presence: true
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
