require 'rails_helper'

RSpec.describe TemplateExercise, type: :model do
  subject { 
    described_class.new(
      workout_template: WorkoutTemplate.new(user: User.new(name: "John Doe", email: "john.doe@example.com", password: "password")),
      exercisable: Exercise.new(name: "Push Up")
    )
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a workout template' do
    subject.workout_template = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:workout_template]).to include("must exist")
  end

  it 'is invalid without an exercisable' do
    subject.exercisable = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:exercisable]).to include("must exist")
  end

  it 'belongs to a workout template' do
    assoc = described_class.reflect_on_association(:workout_template)
    expect(assoc.macro).to eq :belongs_to
  end

  it 'belongs to an exercisable (polymorphic)' do
    assoc = described_class.reflect_on_association(:exercisable)
    expect(assoc.macro).to eq :belongs_to
    expect(assoc.options[:polymorphic]).to be true
  end
end
