# frozen_string_literal: true

class CreateUserExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :user_exercises do |t|
      t.integer :user_id
      t.string :name
      t.text :instructions

      t.timestamps
    end
  end
end
