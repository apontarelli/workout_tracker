class Workout < ApplicationRecord
    belongs_to :user
    belongs_to :program, optional: true
    has_many :workout_exercises

    accepts_nested_attributes_for :workout_exercises, allow_destroy: true

    before_save :set_user_id

    private

    def set_user_id
        self.user_id = current_user.id if user_id.blank?
    end
end
