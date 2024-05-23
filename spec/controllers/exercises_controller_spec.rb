require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  let(:user) { User.create!(name: 'John Doe', email: 'test@example.com', password: 'password', password_confirmation: 'password') }
  let(:global_exercise) { Exercise.create!(name: 'Push Up', instructions: 'A basic push-up exercise', primary_muscle_group: 'Chest', secondary_muscle_groups: ['Triceps'], equipment: 'None', exercise_group: 'Strength') }
  let(:user_exercise) { UserExercise.create!(name: 'User Exercise', primary_muscle_group: 'Legs', secondary_muscle_groups: ['Glutes'], equipment: 'Dumbbells', exercise_group: 'Strength', user: user) }

  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns combined exercises as @combined_exercises" do
      global_exercise
      user_exercise
      get :index
      expect(assigns(:combined_exercises)).to include(["Push Up", "Exercise-#{global_exercise.id}"], ["User Exercise", "UserExercise-#{user_exercise.id}"])
    end
  end

  describe "GET #show" do
    context "when exercise is a global exercise" do
      it "renders the show template for global exercise" do
        get :show, params: { id: global_exercise.to_param }
        expect(response).to render_template(:show)
      end
    end

    context "when exercise is a user exercise" do
      it "renders the show template for user exercise" do
        get :show, params: { id: user_exercise.to_param }
        expect(response).to render_template(:show)
      end
    end
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end
end
