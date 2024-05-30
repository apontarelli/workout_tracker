# frozen_string_literal: true

class WorkoutSet < ApplicationRecord
  # Associations
  belongs_to :workout_exercise

  # Validations
  validates :reps, presence: true
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
