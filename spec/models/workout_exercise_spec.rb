require 'rails_helper'

RSpec.describe WorkoutExercise, type: :model do
  subject { 
    described_class.new(
      workout: Workout.new(user: User.new(name: "John Doe", email: "john.doe@example.com", password: "password")),
      exercisable: Exercise.new(name: "Push Up")
    )
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a workout' do
    subject.workout = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:workout]).to include("must exist")
  end

  it 'is invalid without an exercisable' do
    subject.exercisable = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:exercisable]).to include("must exist")
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
end
