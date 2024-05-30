# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workout do
  let(:user) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  let(:program) { Program.create(user:, name: 'Program 1') }
  let(:exercise) { Exercise.create(name: 'Push Up') }

  before do
    # Define a dummy current_user method in the Workout model for testing purposes
    described_class.class_eval do
      attr_accessor :current_user

      before_save :set_user_id

      attr_reader :current_user
    end
  end

  subject do
    described_class.new(
      user:,
      name: 'Workout 1',
      current_user: user
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a user' do
    subject.user = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:user]).to include('must exist')
  end

  it 'can belong to a program' do
    subject.program = program
    expect(subject).to be_valid
  end

  it 'can have many workout exercises' do
    assoc = described_class.reflect_on_association(:workout_exercises)
    expect(assoc.macro).to eq :has_many
  end

  it 'accepts nested attributes for workout exercises' do
    workout_exercise_attributes = {
      workout_exercises_attributes: [{
        combined_exercise_id: "Exercise-#{exercise.id}",
        workout_sets_attributes: [{ reps: 10, weight: 50 }]
      }]
    }
    subject.assign_attributes(workout_exercise_attributes)
    subject.save

    expect(subject.workout_exercises.length).to eq 1
    workout_exercise = subject.workout_exercises.first
    expect(workout_exercise.exercisable_type).to eq 'Exercise'
    expect(workout_exercise.exercisable_id).to eq exercise.id
    expect(workout_exercise.workout_sets.length).to eq 1
    expect(workout_exercise.workout_sets.first.reps).to eq 10
    expect(workout_exercise.workout_sets.first.weight).to eq 50
  end

  it 'does not overwrite user_id if it is already set' do
    subject.user_id = 999
    subject.save
    expect(subject.user_id).to eq(999)
  end
end
