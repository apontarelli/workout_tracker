# frozen_string_literal: true

class ConvertIntegerRelationsToForeignKeys < ActiveRecord::Migration[7.1]
  def change
    change_table :workouts do |t|
      t.remove :user_id
      t.references :user, null: false, foreign_key: true
      t.remove :program_id
      t.references :program, null: true, foreign_key: true
    end
    change_table :user_exercises do |t|
      t.remove :user_id
      t.references :user, null: false, foreign_key: true
    end
    change_table :programs do |t|
      t.remove :user_id
      t.references :user, null: false, foreign_key: true
    end
    change_table :workout_exercises do |t|
      t.remove :workout_id
      t.references :workout, null: false, foreign_key: true
    end
  end
end
