require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:joseph)
    @other_user = users(:jonah)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end
end
