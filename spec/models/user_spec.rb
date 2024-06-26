# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject do
    described_class.new(
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password'
    )
  end

  # Validation Tests

  # Name validation
  it 'is valid with a name' do
    expect(subject).to be_valid
  end

  it 'is invalid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:name]).to include("can't be blank")
  end

  # Email validation
  it 'is valid with a valid email' do
    expect(subject).to be_valid
  end

  it 'is invalid without an email' do
    subject.email = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    described_class.create!(name: 'Jane Doe', email: 'john.doe@example.com', password: 'password')
    expect(subject).not_to be_valid
    expect(subject.errors[:email]).to include('has already been taken')
  end

  it 'is invalid with an improperly formatted email' do
    subject.email = 'invalid_email'
    expect(subject).not_to be_valid
    expect(subject.errors[:email]).to include('is invalid')
  end

  # Password validation
  it 'is valid with a password of minimum length' do
    expect(subject).to be_valid
  end

  it 'is invalid without a password' do
    subject.password = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a short password' do
    subject.password = 'short'
    expect(subject).not_to be_valid
    expect(subject.errors[:password]).to include('is too short (minimum is 6 characters)')
  end

  context 'when updating an existing user' do
    let(:existing_user) do
      described_class.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password')
    end

    it 'is valid with a password of minimum length' do
      existing_user.password = 'password'
      expect(existing_user).to be_valid
    end

    it 'is invalid with a short password' do
      existing_user.password = 'short'
      expect(existing_user).not_to be_valid
      expect(existing_user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'is valid without changing the password' do
      existing_user.name = 'Updated Name'
      expect(existing_user).to be_valid
    end
  end

  # Associations
  it 'has many workouts' do
    assoc = described_class.reflect_on_association(:workouts)
    expect(assoc.macro).to eq :has_many
  end

  it 'has many workout_templates' do
    assoc = described_class.reflect_on_association(:workout_templates)
    expect(assoc.macro).to eq :has_many
  end

  it 'has many programs' do
    assoc = described_class.reflect_on_association(:programs)
    expect(assoc.macro).to eq :has_many
  end

  it 'has many user_exercises' do
    assoc = described_class.reflect_on_association(:user_exercises)
    expect(assoc.macro).to eq :has_many
  end
end
