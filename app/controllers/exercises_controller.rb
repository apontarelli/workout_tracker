class ExercisesController < ApplicationController
  include ExercisesHelper

  def index
    @combined_exercises = combined_exercises(current_user)
  end

  def show
  end
end
