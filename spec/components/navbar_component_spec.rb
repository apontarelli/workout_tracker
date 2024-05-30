# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NavbarComponent, type: :component do
  let(:user) { User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password') }

  before do
    allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(user)
    allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true)
  end

  it 'renders the navbar with links to the different pages' do
    render_inline(described_class.new(user))

    expect(rendered_content).to have_link('Dashboard', href: root_path)
    expect(rendered_content).to have_link('Workouts', href: workouts_path)
    expect(rendered_content).to have_link('Programs', href: programs_path)
    expect(rendered_content).to have_link('Exercises', href: exercises_path)
  end
end
