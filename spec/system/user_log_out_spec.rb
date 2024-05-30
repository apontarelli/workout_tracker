# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User log out' do
  it 'allows a user to log out' do
    user = User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password')

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'

    click_link_or_button 'Log in'
    click_link_or_button 'User'
    click_link_or_button 'Log out'

    expect(page).to have_content('You are not logged in')
  end
end
