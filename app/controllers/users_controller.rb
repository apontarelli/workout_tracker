class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :correct_user, only: [:edit, :update]
  
    # GET /users/1
    def show
        @user = User.find(params[:id])
        Rails.logger.debug("UsersController Show: #{@user.inspect}")
    end
  
    # GET /signup
    def new
      @user = User.new
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        redirect_to @user, notice: 'Welcome! Your account has been created successfully.'
      else
        render :new
      end
    end
  
    # GET /users/1/edit
    def edit
    end
  
    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'Profile was successfully updated.'
      else
        render :edit
      end
    end
  
    private
      def set_user
        Rails.logger.debug("Params ID: #{params[:id]}")
        @user = User.find(params[:id])
      end
  
      def correct_user
        redirect_to(root_url) unless current_user == @user
      end
  
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
  end
  