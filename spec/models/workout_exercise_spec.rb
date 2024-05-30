# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkoutExercise do
  let(:user) { User.new(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  let(:workout) { Workout.new(user:) }
  let(:exercise) { Exercise.new(name: 'Push Up') }

  subject do
    described_class.new(
      workout:,
      exercisable: exercise,
      combined_exercise_id: "Exercise-#{exercise.id}"
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a workout' do
    subject.workout = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:workout]).to include('must exist')
  end

  it 'is invalid without an exercisable' do
    subject.exercisable = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:exercisable]).to include('must exist')
  end

  it 'belongs to a workout' do
    assoc = described_class.reflect_on_association(:workout)
    expect(assoc.macro).to eq :belongs_to
  end

  it 'belongs to an exercisable (polymorphic)' do
    assoc = described_class.reflect_on_association(:exercisable)
    expect(assoc.macro).to eq :belongs_to
    expect(assoc.options[:polymorphic]).to be true
  end

  it 'has many workout sets' do
    assoc = described_class.reflect_on_association(:workout_sets)
    expect(assoc.macro).to eq :has_many
  end

  it 'accepts nested attributes for workout sets' do
    expect(described_class.nested_attributes_options).to include(:workout_sets)
  end

  it 'sets exercisable based on combined_exercise_id before validation' do
    subject.combined_exercise_id = "Exercise-#{exercise.id}"
    subject.valid?
    expect(subject.exercisable_type).to eq 'Exercise'
    expect(subject.exercisable_id).to eq exercise.id
  end

  it 'calls set_exercisable before validation' do
    workout_exercise = described_class.new(
      workout:,
      combined_exercise_id: "Exercise-#{exercise.id}"
    )
    expect(workout_exercise).to receive(:set_exercisable)
    workout_exercise.valid?
  end
end
