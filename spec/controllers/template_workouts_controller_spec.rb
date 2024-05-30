# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemplateWorkoutsController do
  let(:user) { create(:user) }
  let(:program) { create(:program, user:) }
  let(:template_workout) { create(:template_workout, program:, user:) }

  before do
    # Manually sign in the user
    session[:user_id] = user.id
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new template workout' do
        expect do
          post :create, params: { program_id: program.id, template_workout: attributes_for(:template_workout) }
        end.to change(program.template_workouts, :count).by(1)
      end

      it 'redirects to the edit template workout path' do
        post :create, params: { program_id: program.id, template_workout: attributes_for(:template_workout) }
        expect(response).to redirect_to(edit_program_template_workout_path(program, assigns(:template_workout)))
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns @template_workout' do
      get :edit, params: { program_id: program.id, id: template_workout.id }
      expect(assigns(:template_workout)).to eq(template_workout)
    end

    it 'assigns @combined_exercises' do
      get :edit, params: { program_id: program.id, id: template_workout.id }
      expect(assigns(:combined_exercises)).not_to be_nil
    end

    it 'renders the programs/template_workouts/edit template' do
      get :edit, params: { program_id: program.id, id: template_workout.id }
      expect(response).to render_template('programs/template_workouts/edit')
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested template workout' do
        patch :update,
              params: { program_id: program.id, id: template_workout.id,
                        template_workout: { name: 'Updated Template Workout' } }
        template_workout.reload
        expect(template_workout.name).to eq('Updated Template Workout')
      end

      it 'redirects to the edit template workout path' do
        patch :update,
              params: { program_id: program.id, id: template_workout.id,
                        template_workout: { name: 'Updated Template Workout' } }
        expect(response).to redirect_to(edit_program_template_workout_path(program, template_workout))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested template workout' do
      template_workout # create the template workout
      expect do
        delete :destroy, params: { program_id: program.id, id: template_workout.id }
      end.to change(program.template_workouts, :count).by(-1)
    end

    it 'redirects to the edit program path' do
      delete :destroy, params: { program_id: program.id, id: template_workout.id }
      expect(response).to redirect_to(edit_program_path(program))
    end
  end
end
