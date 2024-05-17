class Exercise < ApplicationRecord
    has_many :workout_exercises, as: :exercisable
    has_many :template_exercises, as: :exercisable
  
    validates :name, presence: true, uniqueness: true
  
    # Additional attributes
    attribute :primary_muscle_group, :string
    attribute :secondary_muscle_groups, :string, array: true, default: []
    attribute :equipment, :string
    attribute :exercise_group, :string
  end