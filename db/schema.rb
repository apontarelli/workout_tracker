# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_28_065819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_muscle_group"
    t.string "secondary_muscle_groups", default: [], array: true
    t.string "equipment"
    t.string "exercise_group"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_programs_on_user_id"
  end

  create_table "template_exercises", force: :cascade do |t|
    t.bigint "template_workout_id", null: false
    t.integer "exercisable_id"
    t.string "exercisable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_workout_id"], name: "index_template_exercises_on_template_workout_id"
  end

  create_table "template_sets", force: :cascade do |t|
    t.bigint "template_exercise_id", null: false
    t.integer "reps"
    t.decimal "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_exercise_id"], name: "index_template_sets_on_template_exercise_id"
  end

  create_table "template_workouts", force: :cascade do |t|
    t.string "name"
    t.bigint "program_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_template_workouts_on_program_id"
    t.index ["user_id"], name: "index_template_workouts_on_user_id"
  end

  create_table "user_exercises", force: :cascade do |t|
    t.string "name"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_muscle_group"
    t.string "equipment"
    t.string "exercise_group"
    t.string "secondary_muscle_groups", default: [], array: true
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_user_exercises_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.integer "exercisable_id"
    t.string "exercisable_type"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workout_id", null: false
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workout_sets", force: :cascade do |t|
    t.bigint "workout_exercise_id", null: false
    t.integer "reps"
    t.decimal "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workout_exercise_id"], name: "index_workout_sets_on_workout_exercise_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "program_id"
    t.index ["program_id"], name: "index_workouts_on_program_id"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "programs", "users"
  add_foreign_key "template_exercises", "template_workouts"
  add_foreign_key "template_sets", "template_exercises"
  add_foreign_key "template_workouts", "programs"
  add_foreign_key "template_workouts", "users"
  add_foreign_key "user_exercises", "users"
  add_foreign_key "workout_exercises", "workouts"
  add_foreign_key "workout_sets", "workout_exercises"
  add_foreign_key "workouts", "programs"
  add_foreign_key "workouts", "users"
end
