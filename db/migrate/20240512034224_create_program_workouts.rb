# frozen_string_literal: true

class CreateProgramWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :program_workouts do |t|
      t.integer :program_id
      t.string :name

      t.timestamps
    end
  end
end
