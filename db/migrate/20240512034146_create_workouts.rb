class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.date :date
      t.string :name
      t.integer :program_id
      t.integer :user_id

      t.timestamps
    end
  end
end
