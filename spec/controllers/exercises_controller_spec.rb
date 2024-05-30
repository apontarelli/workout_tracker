require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  let(:user) do
    User.create!(name: 'John Doe', email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end
  let(:global_exercise) do
    Exercise.create!(name: 'Push Up', instructions: 'A basic push-up exercise', primary_muscle_group: 'Chest',
                     secondary_muscle_groups: ['Triceps'], equipment: 'None', exercise_group: 'Strength')
  end
  let(:user_exercise) do
    UserExercise.create!(name: 'User Exercise', primary_muscle_group: 'Legs', secondary_muscle_groups: ['Glutes'],
                         equipment: 'Dumbbells', exercise_group: 'Strength', user:)
  end

  before do
    log_in user
  end

  describe 'GET #index' do
    it 'assigns combined exercises as @combined_exercises' do
      global_exercise
      user_exercise
      get :index
      expect(assigns(:combined_exercises)).to include(['Push Up', "Exercise-#{global_exercise.id}"],
                                                      ['User Exercise', "UserExercise-#{user_exercise.id}"])
    end
  end

  describe 'GET #show' do
    context 'when exercise is a global exercise' do
      it 'renders the show template for global exercise' do
        get :show, params: { id: global_exercise.to_param }
        expect(response).to render_template(:show)
      end
    end

    context 'when exercise is a user exercise' do
      it 'renders the show template for user exercise' do
        get :show, params: { id: user_exercise.to_param }
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'GET #new_user_exercise' do
    it 'assigns a new user exercise as @user_exercise' do
      get :new_user_exercise
      expect(assigns(:user_exercise)).to be_a_new(UserExercise)
    end
  end

  describe 'POST #create_user_exercise' do
    context 'with valid params' do
      it 'creates a new UserExercise' do
        expect do
          post :create_user_exercise,
               params: { user_exercise: { name: 'Squat', primary_muscle_group: 'Legs', secondary_muscle_groups: ['Glutes'],
                                          equipment: 'None', exercise_group: 'Strength' } }
        end.to change(UserExercise, :count).by(1)
      end

      it 'redirects to the exercises list' do
        post :create_user_exercise,
             params: { user_exercise: { name: 'Squat', primary_muscle_group: 'Legs', secondary_muscle_groups: ['Glutes'],
                                        equipment: 'None', exercise_group: 'Strength' } }
        expect(response).to redirect_to(exercises_path)
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create_user_exercise,
             params: { user_exercise: { name: '', primary_muscle_group: 'Legs', secondary_muscle_groups: ['Glutes'],
                                        equipment: 'None', exercise_group: 'Strength' } }
        expect(response).to render_template(:new_user_exercise)
      end
    end
  end

  describe 'GET #edit_user_exercise' do
    it 'assigns the requested user exercise as @user_exercise' do
      get :edit_user_exercise, params: { id: user_exercise.to_param }
      expect(assigns(:user_exercise)).to eq(user_exercise)
    end
  end

  describe 'PATCH #update_user_exercise' do
    context 'with valid params' do
      it 'updates the requested user exercise' do
        patch :update_user_exercise, params: { id: user_exercise.to_param, user_exercise: { name: 'Updated Exercise' } }
        user_exercise.reload
        expect(user_exercise.name).to eq('Updated Exercise')
      end

      it 'redirects to the exercises list' do
        patch :update_user_exercise, params: { id: user_exercise.to_param, user_exercise: { name: 'Updated Exercise' } }
        expect(response).to redirect_to(exercises_path)
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update_user_exercise, params: { id: user_exercise.to_param, user_exercise: { name: '' } }
        expect(response).to render_template(:edit_user_exercise)
      end
    end
  end

  describe 'DELETE #destroy_user_exercise' do
    it 'destroys the requested user exercise' do
      user_exercise
      expect do
        delete :destroy_user_exercise, params: { id: user_exercise.to_param }
      end.to change(UserExercise, :count).by(-1)
    end

    it 'redirects to the exercises list' do
      delete :destroy_user_exercise, params: { id: user_exercise.to_param }
      expect(response).to redirect_to(exercises_path)
    end
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end
end
