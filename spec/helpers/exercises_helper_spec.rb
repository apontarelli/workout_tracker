# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesHelper do
  let(:user) do
    User.create!(
      name: 'John Doe',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  before do
    Exercise.delete_all
    UserExercise.delete_all

    @global_exercise = Exercise.create!(
      name: 'Push Up',
      instructions: 'A basic push-up exercise',
      primary_muscle_group: 'Chest',
      secondary_muscle_groups: ['Triceps'],
      equipment: 'None',
      exercise_group: 'Strength'
    )

    @user_exercise = UserExercise.create!(
      name: 'User Exercise',
      primary_muscle_group: 'Legs',
      secondary_muscle_groups: ['Glutes'],
      equipment: 'Dumbbells',
      exercise_group: 'Strength',
      user:
    )
  end

  describe '#combined_exercises' do
    it 'returns a combined list of global and user exercises' do
      result = helper.combined_exercises(user)
      expected_result = [
        ['Push Up', "Exercise-#{@global_exercise.id}"],
        ['User Exercise', "UserExercise-#{@user_exercise.id}"]
      ]

      expect(result).to match_array(expected_result)
    end
  end
end
