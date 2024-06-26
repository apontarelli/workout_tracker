# frozen_string_literal: true

class Program < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :template_workouts, dependent: :destroy
end
