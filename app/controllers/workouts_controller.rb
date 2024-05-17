class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts
  end

  def show
    @workout = current_user.workouts.find(params[:id])
  end

  def new
    @workout = current_user.workouts.new  
  end

  def create
    def create
      @workout = current_user.workouts.new(workout_params)
      if @workout.save
        redirect_to @workout, notice: 'Workout was successfully created.'
      else
        render :new
      end
    end    
  end

  def edit
    @workout = current_user.workouts.find(params[:id])
  end

  def update
    @workout = current_user.workouts.find(params[:id])
    if @workout.update(workout_params)
      redirect_to @workout, notice: 'Workout was successfully updated.'
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
    params.require(:workout).permit(:name, :description, :date, :program_id)
  end
end
