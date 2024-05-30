# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  let(:user) { User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs in the user and redirects to the root path' do
        post :create, params: { session: { email: user.email, password: 'password' } }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 're-renders the new template with an alert' do
        post :create, params: { session: { email: user.email, password: 'wrongpassword' } }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq('Invalid email/password combination')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = user.id
    end

    it 'logs out the user and redirects to the root path' do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
