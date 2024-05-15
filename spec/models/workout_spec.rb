require 'rails_helper'

RSpec.describe Workout, type: :model do
  subject { 
    described_class.new(
      user: User.new(name: "John Doe", email: "john.doe@example.com", password: "password")
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
    subject.program = Program.new(user: subject.user, name: "Program 1")
    expect(subject).to be_valid
  end

  it 'can have many workout exercises' do
    assoc = described_class.reflect_on_association(:workout_exercises)
    expect(assoc.macro).to eq :has_many
  end
end
