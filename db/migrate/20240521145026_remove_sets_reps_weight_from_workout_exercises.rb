class RemoveSetsRepsWeightFromWorkoutExercises < ActiveRecord::Migration[7.1]
  def change
    remove_column :workout_exercises, :sets, :integer
    remove_column :workout_exercises, :reps, :integer
    remove_column :workout_exercises, :weight, :float
  end
end
