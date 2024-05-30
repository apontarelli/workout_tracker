class CreateTemplateWorkoutsSetsAndExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :template_workouts do |t|
      t.string :name
      t.references :program, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    create_table :template_exercises do |t|
      t.references :template_workout, null: false, foreign_key: true
      t.integer :exercisable_id
      t.string  :exercisable_type

      t.timestamps
    end
    create_table :template_sets do |t|
      t.references :template_exercise, null: false, foreign_key: true
      t.integer :reps
      t.decimal :weight

      t.timestamps
    end
  end
end
