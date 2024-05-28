class UserExercise < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :workout_exercises, as: :exercisable
  has_many :template_exercises, as: :exercisable

  # Validations
  validates :name, presence: true
end
