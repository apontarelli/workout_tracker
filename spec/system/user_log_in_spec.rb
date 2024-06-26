# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User log in' do
  it 'allows a user to log in' do
    user = User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password')

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'

    click_link_or_button 'Log in'

    expect(page).to have_content('Dashboard#home')
  end

  it 'shows validation errors if form is submitted incorrectly' do
    User.create!(name: 'John Doe', email: 'john.doe@example.com', password: 'password')

    visit login_path

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''

    click_link_or_button 'Log in'

    expect(page).to have_content('You are not logged in')
  end
end
