class AddFieldsToExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :exercises, :primary_muscle_group, :string
    add_column :exercises, :secondary_muscle_groups, :string, array: true, default: []
    add_column :exercises, :equipment, :string
    add_column :exercises, :exercise_group, :string
  end
end
