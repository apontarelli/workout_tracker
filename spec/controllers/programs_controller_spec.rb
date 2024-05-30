# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProgramsController do
  let(:user) { create(:user) }
  let(:program) { create(:program, user:) }

  before do
    # Manually sign in the user
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    it 'assigns @programs' do
      get :index
      expect(assigns(:programs)).to eq(user.programs)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new program' do
        expect do
          post :create, params: { program: attributes_for(:program) }
        end.to change(user.programs, :count).by(1)
      end

      it 'redirects to the edit program path' do
        post :create, params: { program: attributes_for(:program) }
        expect(response).to redirect_to(edit_program_path(assigns(:program)))
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns @program' do
      get :edit, params: { id: program.id }
      expect(assigns(:program)).to eq(program)
    end

    it 'assigns @template_workouts' do
      get :edit, params: { id: program.id }
      expect(assigns(:template_workouts)).to eq(program.template_workouts)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested program' do
        patch :update, params: { id: program.id, program: { name: 'Updated Program' } }
        program.reload
        expect(program.name).to eq('Updated Program')
      end

      it 'redirects to the edit program path' do
        patch :update, params: { id: program.id, program: { name: 'Updated Program' } }
        expect(response).to redirect_to(edit_program_path(program))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested program' do
      program # create the program
      expect do
        delete :destroy, params: { id: program.id }
      end.to change(user.programs, :count).by(-1)
    end

    it 'redirects to the programs list' do
      delete :destroy, params: { id: program.id }
      expect(response).to redirect_to(programs_url)
    end
  end
end
