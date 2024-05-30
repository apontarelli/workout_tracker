# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemplateExercise do
  let(:user) { User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }
  let(:template_workout) { TemplateWorkout.create!(user:, name: 'Workout 1') }
  let(:exercise) { Exercise.create!(name: 'Push Up') }

  subject do
    described_class.new(
      template_workout:,
      exercisable: exercise,
      combined_exercise_id: "Exercise-#{exercise.id}"
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a template_workout' do
    subject.template_workout = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:template_workout]).to include('must exist')
  end

  it 'is invalid without an exercisable' do
    subject.exercisable = nil
    subject.combined_exercise_id = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:exercisable]).to include('must exist')
  end

  it 'belongs to a template workout' do
    assoc = described_class.reflect_on_association(:template_workout)
    expect(assoc.macro).to eq :belongs_to
  end

  it 'belongs to an exercisable (polymorphic)' do
    assoc = described_class.reflect_on_association(:exercisable)
    expect(assoc.macro).to eq :belongs_to
    expect(assoc.options[:polymorphic]).to be true
  end

  it 'has many template sets' do
    assoc = described_class.reflect_on_association(:template_sets)
    expect(assoc.macro).to eq :has_many
  end

  it 'accepts nested attributes for template sets' do
    expect(described_class.nested_attributes_options).to include(:template_sets)
  end

  it 'sets exercisable based on combined_exercise_id before validation' do
    subject.combined_exercise_id = "Exercise-#{exercise.id}"
    subject.valid?
    expect(subject.exercisable_type).to eq 'Exercise'
    expect(subject.exercisable_id).to eq exercise.id
  end

  it 'calls set_exercisable before validation' do
    template_exercise = described_class.new
    expect(template_exercise).to receive(:set_exercisable)
    template_exercise.valid?
  end
end
