require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject do
    described_class.new(
      name: 'Test exercise',
      primary_muscle_group: 'Chest',
      secondary_muscle_groups: %w[Triceps Shoulders],
      equipment: 'None',
      exercise_group: 'Push'
    )
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with a duplicate name' do
      described_class.create!(
        name: 'Test exercise',
        primary_muscle_group: 'Chest',
        secondary_muscle_groups: %w[Triceps Shoulders],
        equipment: 'None',
        exercise_group: 'Push'
      )
      expect(subject).not_to be_valid
    end
  end

  context 'associations' do
    it 'can have many workout exercises' do
      assoc = described_class.reflect_on_association(:workout_exercises)
      expect(assoc.macro).to eq :has_many
    end

    it 'can have many template exercises' do
      assoc = described_class.reflect_on_association(:template_exercises)
      expect(assoc.macro).to eq :has_many
    end
  end
end
