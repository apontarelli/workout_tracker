class TemplateSet < ApplicationRecord
  # Associations
  belongs_to :template_exercise

  # Validations
  validates :reps, presence: true
  validates :weight, presence: true, numericality: {greater_than_or_equal_to: 0}
end
