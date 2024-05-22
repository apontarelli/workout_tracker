class WorkoutsController < ApplicationController
  include ExercisesHelper

  def index
    @workouts = current_user.workouts
  end

  def create
    @workout = current_user.workouts.build(workout_params_with_defaults)
    if @workout.save
      redirect_to edit_workout_path(@workout), notice: 'Workout was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @workout = current_user.workouts.find(params[:id])
    @workout.workout_exercises.build if @workout.workout_exercises.empty?
    @combined_exercises = combined_exercises(current_user)
  end

  def update
    @workout = current_user.workouts.find(params[:id])
    @combined_exercises = combined_exercises(current_user)
    if @workout.update(workout_params)
      redirect_to edit_workout_path(@workout), notice: 'Workout was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy
    redirect_to workouts_url, notice: 'Workout was successfully destroyed.'
  end
  
  private

  def workout_params
    params.require(:workout).permit(:name, :date, :program_id, workout_exercises_attributes: [:id, :exercise_id, :combined_exercise_id, :notes, :_destroy, workout_sets_attributes: [:id, :reps, :weight, :_destroy]
    ]
    ).tap do |whitelisted|
      if whitelisted[:workout_exercises_attributes]
        whitelisted[:workout_exercises_attributes].each do |key, exercise|
          if exercise[:combined_exercise_id]
            type, id = exercise[:combined_exercise_id].split('-')
            exercise[:exercisable_type] = type
            exercise[:exercisable_id] = id
            exercise.delete(:combined_exercise_id)
          end
        end
      end
    end
  end

  def workout_params_with_defaults
    {
      name: 'New Workout',
      date: Date.today
    }
  end
end
