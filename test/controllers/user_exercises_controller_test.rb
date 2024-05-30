# frozen_string_literal: true

require 'test_helper'

class UserExercisesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get user_exercises_new_url
    assert_response :success
  end

  test 'should get create' do
    get user_exercises_create_url
    assert_response :success
  end
end
