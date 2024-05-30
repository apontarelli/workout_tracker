# frozen_string_literal: true

class AddFieldsToUserExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :user_exercises, :primary_muscle_group, :string
    add_column :user_exercises, :equipment, :string
    add_column :user_exercises, :exercise_group, :string
  end
end
