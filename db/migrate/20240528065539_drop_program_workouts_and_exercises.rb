# frozen_string_literal: true

class DropProgramWorkoutsAndExercises < ActiveRecord::Migration[7.1]
  def change
    drop_table :program_exercises
    drop_table :program_workouts
  end
end
