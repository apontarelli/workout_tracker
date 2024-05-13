class User < ApplicationRecord
    has_secure_password
    has_many :workouts
    has_many :workout_templates
    has_many :programs
    has_many :user_exercises
end
