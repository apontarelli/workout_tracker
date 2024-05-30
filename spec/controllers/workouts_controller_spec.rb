require 'rails_helper'

RSpec.describe WorkoutsController, type: :controller do
  let(:user) do
    User.create!(name: 'John Doe', email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end
  let(:workout) { Workout.create!(name: 'Workout 1', date: Date.today, user:) }
  let(:valid_attributes) { { name: 'Workout 1', date: Date.today } }
  let(:invalid_attributes) { { name: nil } }

  before do
    log_in user
  end

  describe 'GET #index' do
    it "assigns the user's workouts as @workouts" do
      workout
      get :index
      expect(assigns(:workouts)).to eq([workout])
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Workout' do
        expect do
          post :create, params: { workout: valid_attributes }
        end.to change(Workout, :count).by(1)
      end

      it 'redirects to the edit workout path' do
        post :create, params: { workout: valid_attributes }
        expect(response).to redirect_to(edit_workout_path(Workout.last))
      end
    end

    context 'with invalid params' do
      it 'uses default params and creates a new Workout' do
        expect do
          post :create, params: { workout: invalid_attributes }
        end.to change(Workout, :count).by(1)
      end

      it 'redirects to the edit workout path using default params' do
        post :create, params: { workout: invalid_attributes }
        expect(response).to redirect_to(edit_workout_path(Workout.last))
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested workout as @workout' do
      get :edit, params: { id: workout.to_param }
      expect(assigns(:workout)).to eq(workout)
    end

    it 'builds workout_exercises if empty' do
      workout.workout_exercises.destroy_all
      get :edit, params: { id: workout.to_param }
      expect(assigns(:workout).workout_exercises.size).to eq(1)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Workout' } }

      it 'updates the requested workout' do
        patch :update, params: { id: workout.to_param, workout: new_attributes }
        workout.reload
        expect(workout.name).to eq('Updated Workout')
      end

      it 'redirects to the edit workout path' do
        patch :update, params: { id: workout.to_param, workout: new_attributes }
        expect(response).to redirect_to(edit_workout_path(workout))
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { id: workout.to_param, workout: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested workout' do
      workout
      expect do
        delete :destroy, params: { id: workout.to_param }
      end.to change(Workout, :count).by(-1)
    end

    it 'redirects to the workouts list' do
      delete :destroy, params: { id: workout.to_param }
      expect(response).to redirect_to(workouts_url)
    end
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end
end
