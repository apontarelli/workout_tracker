# frozen_string_literal: true

class WorkoutsController < ApplicationController
  include ExercisesHelper

  def index
    @workouts = current_user.workouts
  end

  def edit
    @workout = current_user.workouts.find(params[:id])
    @workout.workout_exercises.build if @workout.workout_exercises.empty?
    @combined_exercises = combined_exercises(current_user)
  end

  def create
    @workout = current_user.workouts.build(workout_params_with_defaults)
    if @workout.save
      redirect_to edit_workout_path(@workout), notice: 'Workout was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @workout = current_user.workouts.find(params[:id])
    @combined_exercises = combined_exercises(current_user)
    if @workout.update(workout_params)
      redirect_to edit_workout_path(@workout), notice: 'Workout was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy
    redirect_to workouts_url, notice: 'Workout was successfully destroyed.'
  end

  def workout_params
    whitelisted = params.require(:workout).permit(*permitted_workout_attributes)
    process_combined_exercise_ids(whitelisted[:workout_exercises_attributes])
    whitelisted
  end

  private

  def permitted_workout_attributes
    [
      :name, :date, :program_id,
      { workout_exercises_attributes: [
        :id, :exercise_id, :combined_exercise_id, :notes, :_destroy,
        { workout_sets_attributes: %i[id reps weight _destroy] }
      ] }
    ]
  end

  def process_combined_exercise_ids(workout_exercises_attributes)
    workout_exercises_attributes&.each_value do |exercise|
      next unless exercise[:combined_exercise_id]

      type, id = exercise[:combined_exercise_id].split('-')
      exercise[:exercisable_type] = type
      exercise[:exercisable_id] = id
      exercise.delete(:combined_exercise_id)
    end
  end

  def workout_params_with_defaults
    {
      name: 'New Workout',
      date: Time.zone.today
    }
  end
end
