class Program < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :workout_templates, dependent: :destroy
end
