# frozen_string_literal: true

class Exercise < ApplicationRecord
  # Associations
  has_many :workout_exercises, as: :exercisable
  has_many :template_exercises, as: :exercisable

  # Validations
  validates :name, presence: true, uniqueness: true
end
