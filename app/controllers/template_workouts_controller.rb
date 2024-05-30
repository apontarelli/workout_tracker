class TemplateWorkoutsController < ApplicationController
  include ExercisesHelper

  before_action :set_program
  before_action :set_template_workout, only: %i[edit update destroy]

  def edit
    @template_workout.template_exercises.build if @template_workout.template_exercises.empty?
    @combined_exercises = combined_exercises(current_user)
    render 'programs/template_workouts/edit'
  end

  def create
    @template_workout = @program.template_workouts.build(template_workout_params_with_defaults)
    @template_workout.user = current_user

    if @template_workout.save
      redirect_to edit_program_template_workout_path(@program, @template_workout),
                  notice: 'Program workout was successfully created.'
    else
      @template_workouts = @program.template_workouts
      @combined_exercises = combined_exercises(current_user)
      render 'programs/edit', status: :unprocessable_entity
    end
  end

  def update
    @combined_exercises = combined_exercises(current_user)
    if @template_workout.update(template_workout_params)
      redirect_to edit_program_template_workout_path(@program, @template_workout),
                  notice: 'Program workout was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @template_workout.destroy
    redirect_to edit_program_path(@program), notice: 'Program workout was successfully destroyed.'
  end

  private

  def set_program
    @program = current_user.programs.find(params[:program_id])
  end

  def set_template_workout
    @template_workout = @program.template_workouts.find(params[:id])
  end

  def template_workout_params
    params.require(:template_workout).permit(
      :name,
      template_exercises_attributes: [
        :id, :exercise_id, :combined_exercise_id, :notes, :_destroy,
        {
          template_sets_attributes: %i[id reps weight _destroy exercise_entry_id exercise_entry_type]
        }
      ]
    ).tap do |whitelisted|
      if whitelisted[:template_exercises_attributes]
        whitelisted[:template_exercises_attributes].each do |_key, exercise|
          next unless exercise[:combined_exercise_id]
  
          type, id = exercise[:combined_exercise_id].split('-')
          exercise[:exercisable_type] = type
          exercise[:exercisable_id] = id
          exercise.delete(:combined_exercise_id)
        end
      end
    end
  end
  

  def template_workout_params_with_defaults
    {
      name: 'New Program Workout'
    }
  end
end
