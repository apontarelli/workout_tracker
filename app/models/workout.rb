class Workout < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :program, optional: true
  has_many :workout_exercises

  # Nested Attributes
  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

  # Validations
  validates :name, presence: true
### Below should be deleted and fixed in controller
  # Callbacks
  before_save :set_user_id

  # Instance Methods
  private

  def set_user_id
      self.user_id = current_user.id if user_id.blank?
  end
end
