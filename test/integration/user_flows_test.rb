require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "user can sign up" do
    # Load the signup page.
    get '/signup'
    assert_response :success

    # Sign up.
    password = User.digest('password123')
    post users_path, params: { user: {
       username: 'tester1234',
       password: password,
       password_confirmation: password,
       email: 'tester1234@example.com' } }

    # Be redirected to the homepage
    assert_response :redirect
  end
end
