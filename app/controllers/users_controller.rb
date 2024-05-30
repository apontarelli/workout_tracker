class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :correct_user, only: %i[edit update]
  skip_before_action :authenticate_user!, only: %i[new create]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, notice: 'Welcome! Your account has been created successfully.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to(root_url) unless current_user == @user
  end

  def user_params
    params.require(:user).permit(:name, :email).tap do |user_params|
      if params[:user][:password].present?
        user_params[:password] = params[:user][:password]
        user_params[:password_confirmation] = params[:user][:password_confirmation]
      end
    end
  end
end
