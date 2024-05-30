# frozen_string_literal: true

class CreateProgramExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :program_exercises do |t|
      t.integer :program_workout_id
      t.integer :exercisable_id
      t.string :exercisable_type
      t.integer :sets
      t.integer :reps

      t.timestamps
    end
  end
end
