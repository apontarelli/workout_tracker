require 'rails_helper'

RSpec.describe 'User sign up', type: :system do
    it 'allows a user to sign up' do
        visit signup_path

        fill_in 'Name', with: 'John Doe'
        fill_in 'Email', with: 'john.doe@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'

        click_button 'Create User'

        expect(page).to have_content('Dashboard')
        expect(page).to have_content('John Doe')
    end

    it 'shows validation errors if form is submitted incorrectly' do
        visit signup_path

        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'mismatch'

        click_button 'Create User'

        expect(page).to have_content('Name can\'t be blank')
        expect(page).to have_content('Email is invalid')
        expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
end