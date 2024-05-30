# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      render plain: 'Success'
    end
  end

  let(:user) { User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }

  context 'when user is not logged in' do
    it 'redirects to login page' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  context 'when user is logged in' do
    before do
      session[:user_id] = user.id
    end

    it 'allows access to the action' do
      get :index
      expect(response).to be_successful
      expect(response.body).to eq('Success')
    end
  end
end
