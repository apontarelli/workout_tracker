class Program < ApplicationRecord
    belongs_to :user
    has_many :workout_templates
end
