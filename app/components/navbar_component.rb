class NavbarComponent < ViewComponent::Base
  include Rails.application.routes.url_helpers
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
end