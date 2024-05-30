# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemplateSet do
  let(:user) { User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  let(:template_workout) { TemplateWorkout.create!(user:, name: 'Morning Workout') }
  let(:exercise) { Exercise.create!(name: 'Push Up') }
  let(:template_exercise) { TemplateExercise.create!(template_workout:, exercisable: exercise) }

  it 'belongs to a template exercise' do
    association = described_class.reflect_on_association(:template_exercise)
    expect(association.macro).to eq :belongs_to
  end

  it 'is not valid without a template_exercise_id' do
    template_set = described_class.new(template_exercise_id: nil)
    expect(template_set).not_to be_valid
    expect(template_set.errors[:template_exercise]).to include('must exist')
  end

  it 'is valid with valid attributes' do
    template_set = described_class.new(template_exercise:, reps: 10, weight: 50.0)
    expect(template_set).to be_valid
  end

  it 'is not valid without reps' do
    template_set = described_class.new(template_exercise:, reps: nil, weight: 50.0)
    expect(template_set).not_to be_valid
    expect(template_set.errors[:reps]).to include("can't be blank")
  end

  it 'is not valid without weight' do
    template_set = described_class.new(template_exercise:, reps: 10, weight: nil)
    expect(template_set).not_to be_valid
    expect(template_set.errors[:weight]).to include("can't be blank")
  end

  it 'has numeric weight greater than or equal to 0' do
    template_set = described_class.new(template_exercise:, reps: 10, weight: -1)
    expect(template_set).not_to be_valid
    expect(template_set.errors[:weight]).to include('must be greater than or equal to 0')
  end

  it 'has numeric weight' do
    template_set = described_class.new(template_exercise:, reps: 10, weight: 'fifty')
    expect(template_set).not_to be_valid
    expect(template_set.errors[:weight]).to include('is not a number')
  end
end
