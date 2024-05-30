# frozen_string_literal: true

class ExercisesController < ApplicationController
  include ExercisesHelper

  before_action :set_user_exercise, only: %i[edit_user_exercise update_user_exercise destroy_user_exercise]

  def index
    @combined_exercises = combined_exercises(current_user)
  end

  def show; end

  def new_user_exercise
    @user_exercise = UserExercise.new
  end

  def create_user_exercise
    @user_exercise = UserExercise.new(user_exercise_params)
    @user_exercise.user = current_user

    if @user_exercise.save
      redirect_to exercises_path, notice: 'User exercise was successfully created.'
    else
      render :new_user_exercise
    end
  end

  def edit_user_exercise; end

  def update_user_exercise
    if @user_exercise.update(user_exercise_params)
      redirect_to exercises_path, notice: 'User exercise was successfully updated.'
    else
      render :edit_user_exercise
    end
  end

  def destroy_user_exercise
    @user_exercise.destroy
    redirect_to exercises_path, notice: 'User exercise was successfully destroyed.'
  end

  private

  def set_user_exercise
    @user_exercise = UserExercise.find(params[:id])
  end

  def user_exercise_params
    params.require(:user_exercise).permit(:name, :primary_muscle_group, :equipment, :exercise_group,
                                          secondary_muscle_groups: [])
  end
end
