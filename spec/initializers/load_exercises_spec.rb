require 'rails_helper'

RSpec.describe "LoadExercisesInitializer", type: :request do
  it 'loads exercises from YAML file' do
    # Ensure the database is clean
    Exercise.delete_all

    # Manually run the initializer code
    exercise_file = Rails.root.join('config', 'exercises.yml')
    exercises = YAML.load_file(exercise_file)['exercises']

    exercises.each do |exercise_data|
      Exercise.find_or_create_by(name: exercise_data['name']) do |exercise|
        exercise.primary_muscle_group = exercise_data['primary_muscle_group']
        exercise.secondary_muscle_groups = exercise_data['secondary_muscle_groups']
        exercise.equipment = exercise_data['equipment']
        exercise.exercise_group = exercise_data['exercise_group']
      end
    end

    # Verify the exercises were loaded correctly
    expect(Exercise.count).to eq(exercises.size)

    exercises.each do |exercise_data|
      exercise = Exercise.find_by(name: exercise_data['name'])
      expect(exercise).to be_present
      expect(exercise.primary_muscle_group).to eq(exercise_data['primary_muscle_group'])
      expect(exercise.secondary_muscle_groups).to eq(exercise_data['secondary_muscle_groups'])
      expect(exercise.equipment).to eq(exercise_data['equipment'])
      expect(exercise.exercise_group).to eq(exercise_data['exercise_group'])
    end
  end
end
