# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsHelper do
  let(:user) { User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }

  describe '#log_in' do
    it 'logs in the user by setting the session user_id' do
      log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe '#current_user' do
    it 'returns the current logged-in user based on session user_id' do
      log_in(user)
      expect(current_user).to eq(user)
    end

    it 'returns nil if there is no user logged in' do
      expect(current_user).to be_nil
    end
  end

  describe '#logged_in?' do
    it 'returns true if a user is logged in' do
      log_in(user)
      expect(logged_in?).to be true
    end

    it 'returns false if no user is logged in' do
      expect(logged_in?).to be false
    end
  end

  describe '#log_out' do
    it 'logs out the user by clearing the session user_id' do
      log_in(user)
      log_out
      expect(session[:user_id]).to be_nil
      expect(current_user).to be_nil
    end
  end
end
