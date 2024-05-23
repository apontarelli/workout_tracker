require 'rails_helper'

RSpec.describe WorkoutSet, type: :model do
  let(:user) { User.create!(name: "John Doe", email: "john.doe@example.com", password: "password") }
  let(:workout) { Workout.create!(user: user) }
  let(:exercise) { Exercise.create!(name: "Push Up") }
  let(:workout_exercise) { WorkoutExercise.create!(workout: workout, exercisable: exercise) }

  it "belongs to a workout exercise" do
    association = described_class.reflect_on_association(:workout_exercise)
    expect(association.macro).to eq :belongs_to
  end

  it "is not valid without a workout_exercise_id" do
    workout_set = WorkoutSet.new(workout_exercise_id: nil)
    expect(workout_set).not_to be_valid
    expect(workout_set.errors[:workout_exercise]).to include("must exist")
  end

  it "is valid with valid attributes" do
    workout_set = WorkoutSet.new(workout_exercise: workout_exercise, reps: 10, weight: 50.0)
    expect(workout_set).to be_valid
  end

  it "is not valid without reps" do
    workout_set = WorkoutSet.new(workout_exercise: workout_exercise, reps: nil, weight: 50.0)
    expect(workout_set).not_to be_valid
    expect(workout_set.errors[:reps]).to include("can't be blank")
  end

  it "is not valid without weight" do
    workout_set = WorkoutSet.new(workout_exercise: workout_exercise, reps: 10, weight: nil)
    expect(workout_set).not_to be_valid
    expect(workout_set.errors[:weight]).to include("can't be blank")
  end

  it "has numeric weight greater than or equal to 0" do
    workout_set = WorkoutSet.new(workout_exercise: workout_exercise, reps: 10, weight: -1)
    expect(workout_set).not_to be_valid
    expect(workout_set.errors[:weight]).to include("must be greater than or equal to 0")
  end

  it "has numeric weight" do
    workout_set = WorkoutSet.new(workout_exercise: workout_exercise, reps: 10, weight: 'fifty')
    expect(workout_set).not_to be_valid
    expect(workout_set.errors[:weight]).to include("is not a number")
  end
end
