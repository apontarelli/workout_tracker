require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject { 
    described_class.new(
      name: "Push Up"
    )
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
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
