require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password',
                 password_confirmation: 'password')
  end

  describe 'GET #show' do
    before { log_in user }

    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new User and redirects to the user page' do
        expect do
          post :create,
               params: { user: { name: 'Jane Doe', email: 'jane.doe@example.com', password: 'password',
                                 password_confirmation: 'password' } }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to(User.last)
        expect(flash[:notice]).to eq('Welcome! Your account has been created successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User and re-renders the new template' do
        expect do
          post :create,
               params: { user: { name: '', email: 'invalid', password: 'password', password_confirmation: 'mismatch' } }
        end.not_to change(User, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before { log_in user }

    it 'returns a success response' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'redirects to root if not correct user' do
      other_user = User.create!(name: 'Other User', email: 'other@example.com', password: 'password',
                                password_confirmation: 'password')
      log_in other_user
      get :edit, params: { id: user.id }
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'PATCH/PUT #update' do
    before { log_in user }

    context 'with valid parameters' do
      it 'updates the user and redirects to the user page' do
        patch :update,
              params: { id: user.id,
                        user: { name: 'John Updated', email: user.email, password: '', password_confirmation: '' } }
        user.reload
        expect(user.name).to eq('John Updated')
        expect(response).to redirect_to(user)
        expect(flash[:notice]).to eq('Profile was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the user and re-renders the edit template' do
        patch :update,
              params: { id: user.id, user: { name: '', email: user.email, password: '', password_confirmation: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end
end
