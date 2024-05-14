class NavbarComponent < ViewComponent::Base
  include Rails.application.routes.url_helpers
  include SessionsHelper

  def initialize(user)
    @user = user
  end

  def render?
    true
  end

  private

  def dashboard_active?
    current_page?(root_path)
  end

  def workouts_active?
    current_page?(workouts_path)
  end

  def programs_active?
    current_page?(programs_path)
  end

  def exercises_active?
    current_page?(exercises_path)
  end

  def user_active?
    current_page?(user_path(@user))
  end
end