# frozen_string_literal: true

class AddSecondaryMuscleGroupsToUserExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :user_exercises, :secondary_muscle_groups, :string, array: true, default: []
  end
end
