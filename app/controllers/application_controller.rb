# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :authenticate_user!

  private

  def authenticate_user!
    return if logged_in?

    redirect_to login_path
  end
end
