class User < ApplicationRecord
  # Associations
  has_many :workouts
  has_many :workout_templates
  has_many :programs
  has_many :user_exercises
  has_secure_password

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, allow_nil: true, on: :update
end