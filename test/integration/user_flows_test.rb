require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @new_user = build :user
    @existing_user = create :user
  end

  teardown do
    @user = nil
    @existing_user = nil
  end

  test "should see the signup page" do
    get signup_url
    assert_response :success
    assert_select "h1", "Hello,"
    assert_select "button", "Let's go!"
  end

  test "should be able to sign up and see the edit diary page" do
    signup(@new_user)
    assert_redirected_to edit_diary_url
    follow_redirect!
    assert_response :success
    assert_select "span", "Edit Diary"
  end

  test "should see the signin page" do
    get signin_url
    assert_response :success
    assert_select "h1", "Welcome back!"
    assert_select "button", "Get me in!"
  end

  test "should be able to sign in and see today diary page" do
    signin(@existing_user)
    assert_redirected_to today_url
    follow_redirect!
    assert_response :success
    assert_select "span", "#{ humanized_date(DateTime.current) }"
  end

  test "should be able to see the settings page" do
    signin(@existing_user)
    get settings_url
    assert_response :success
    assert_select "span", "Settings"
  end

  test "should be able to sign out" do
    signin(@existing_user)
    signout
    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "should be able to update himself" do
    signin(@existing_user)
    patch edit_user_url, params: { user: { email: @new_user.email,
                                           first_name: @new_user.first_name,
                                           last_name: @new_user.last_name,
                                           password: default_new_password } }

    assert_redirected_to settings_url
    follow_redirect!
    assert_response :success
    assert_select "input#user_email[value=?]", "#{ @new_user.email }"
    assert_select "input#user_first_name[value=?]", "#{ @new_user.first_name }"
    assert_select "input#user_last_name[value=?]", "#{ @new_user.last_name }"
  end

  test "shoud be able to delete account" do
    signin(@existing_user)
    delete delete_account_url
    assert_redirected_to signup_url
    follow_redirect!
    assert_response :success
  end

  test "should see the gravatar if exists" do
    @new_user.email = "jitewaboh@lagify.com"
    signup(@new_user)
    follow_redirect!
    assert_select "a#settings-button" do
      assert_select "img[alt=#{@new_user.first_name}]"
    end
  end

  test "should be redirected to signin page when GETting restricted resources if signed out" do
    URLS = [
      settings_url]

      URLS.each do |url|
      get url
      assert_redirected_to signin_url
      follow_redirect!
      assert_response :success
    end
  end

  test "should be redirected to signin page when trying to update data signed out" do
    patch edit_user_url(@existing_user), params: { user: { email: "test@example.com" } }

    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "should be redirected to signin page when trying to delete data signed out" do
    delete delete_account_url(@existing_user)

    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "user should be redirected to signin page when DELETing restricted rescources if signed out" do

  end

end