require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:joseph)
    @other_user = users(:jonah)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "password",
                                              password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    #Assert equal checks if two comma separated values are equal
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "should redirect edit when logged in as wrong user" do
    #log_in_as (@other_user)
    #get edit_user_path(@user) 
    #assert flash.empty?
    #assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    #assert flash.empty?
    #assert_redirected_to root_url
  end
end