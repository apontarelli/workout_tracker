require 'rails_helper'

RSpec.describe UserExercise, type: :model do
  subject { 
    described_class.new(
      user: User.new(name: "John Doe", email: "john.doe@example.com", password: "password"),
      name: "Custom Exercise"
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

  it 'is invalid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:name]).to include("can't be blank")
  end

  it 'can have many workout exercises' do
    assoc = described_class.reflect_on_association(:workout_exercises)
    expect(assoc.macro).to eq :has_many
  end

  it 'can have many template exercises' do
    assoc = described_class.reflect_on_association(:template_exercises)
    expect(assoc.macro).to eq :has_many
  end
end
