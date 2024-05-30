require 'rails_helper'

RSpec.describe TemplateWorkout, type: :model do
  let(:user) { User.create!(name: "John Doe", email: "john.doe@example.com", password: "password") }
  let(:program) { Program.create!(user: user, name: "Program 1") }
  let(:exercise) { Exercise.create!(name: "Push Up") }

  before do
    # Define a dummy current_user method in the TemplateWorkout model for testing purposes
    described_class.class_eval do
      attr_accessor :current_user

      def current_user
        @current_user
      end
    end
  end

  subject { 
    described_class.new(
      user: user,
      name: "Workout 1",
      current_user: user
    )
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a user' do
    subject.user = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:user]).to include("must exist")
  end

  it 'can belong to a program' do
    subject.program = program
    expect(subject).to be_valid
  end

  it 'can have many template exercises' do
    assoc = described_class.reflect_on_association(:template_exercises)
    expect(assoc.macro).to eq :has_many
  end

  it 'accepts nested attributes for template exercises' do
    template_exercise_attributes = {
      template_exercises_attributes: [{
        combined_exercise_id: "Exercise-#{exercise.id}",
        template_sets_attributes: [{ reps: 10, weight: 50 }]
      }]
    }
    subject.assign_attributes(template_exercise_attributes)
    subject.save

    expect(subject.template_exercises.length).to eq 1
    template_exercise = subject.template_exercises.first
    expect(template_exercise.template_sets.length).to eq 1
    expect(template_exercise.template_sets.first.reps).to eq 10
    expect(template_exercise.template_sets.first.weight).to eq 50
  end

  it 'does not overwrite user_id if it is already set' do
    subject.user_id = 999
    subject.save
    expect(subject.user_id).to eq(999)
  end
end