# frozen_string_literal: true

class CreateWorkoutSets < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_sets do |t|
      t.references :workout_exercise, null: false, foreign_key: true
      t.integer :reps
      t.decimal :weight

      t.timestamps
    end
  end
end
