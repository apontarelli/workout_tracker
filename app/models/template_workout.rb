# frozen_string_literal: true

class TemplateWorkout < ApplicationRecord
  # Associations
  belongs_to :program, optional: true
  belongs_to :user
  has_many :template_exercises, dependent: :destroy

  # Nested Attributes
  accepts_nested_attributes_for :template_exercises, allow_destroy: true

  # Validations
  validates :name, presence: true
end
