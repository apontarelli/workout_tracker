# frozen_string_literal: true

class CreateWorkoutExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_exercises do |t|
      t.integer :workout_id
      t.integer :exercisable_id
      t.string :exercisable_type
      t.integer :sets
      t.integer :reps
      t.float :weight
      t.text :notes

      t.timestamps
    end
  end
end
