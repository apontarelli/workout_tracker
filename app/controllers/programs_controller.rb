class ProgramsController < ApplicationController
  before_action :set_program, only: %i[edit update destroy]

  def index
    @programs = current_user.programs
  end

  def edit
    @template_workouts = @program.template_workouts
  end

  def create
    @program = current_user.programs.build(program_params_with_defaults)
    if @program.save
      redirect_to edit_program_path(@program), notice: 'Program was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @program = current_user.programs.find(params[:id])
    if @program.update(program_params)
      redirect_to edit_program_path(@program), notice: 'Program was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @program = current_user.programs.find(params[:id])
    @program.destroy
    redirect_to programs_url, notice: 'Program was successfully destroyed.'
  end

  private

  def set_program
    @program = Program.find(params[:id])
  end

  def program_params
    params.require(:program).permit(:name, :description)
  end

  def program_params_with_defaults
    {
      name: 'New Program'
    }
  end
end
