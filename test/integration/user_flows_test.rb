require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @new_user = build :user
    @existing_user = create :confirmed_user
    @existing_user_with_gravatar = create :confirmed_user, email: "jitewaboh@lagify.com"
  end

  teardown do
    @new_user, @existing_user, @existing_user_with_gravatar = nil, nil, nil
  end

  test "should see the sign_up page" do
    get signup_url
    assert_response :success
    assert_select "h1", "Hello,"
    assert_select "button", "Let's go!"
  end

  test "should be able to sign up and confirm email" do
    sign_up(@new_user)
    assert_redirected_to check_email_url
    follow_redirect!
    assert_response :success
    assert_select "h1", "Awesome!"

    email_body = ActionMailer::Base.deliveries.first.body.to_s
    confirmation_link = (URI.extract(email_body)).first

    get confirmation_link
    assert_redirected_to signin_url
    assert_equal "Your email address has been successfully confirmed.", flash[:notice]
  end

  test "should see the signin page" do
    get signin_url
    assert_response :success
    assert_select "h1", "Hello"
    assert_select "button", "Get me in!"
  end

  test "should be able to sign in and see today diary page" do
    sign_in(@existing_user)
    get root_path
    assert_response :success
    assert_select "span", "#{ humanized_date(DateTime.current) }"
  end

  test "should be able to see the settings page" do
    sign_in(@existing_user)
    get settings_url
    assert_response :success
    assert_select "span", "Settings"
  end

  test "should be able to sign out" do
    sign_in(@existing_user)
    sign_out_user
    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "should be able to update himself" do
    sign_in(@existing_user)
    patch edit_user_url, params: { user: {
      first_name: @new_user.first_name,
      last_name: @new_user.last_name,
      password: default_new_password,
      current_password: @existing_user.password } }

    assert_redirected_to settings_url
    follow_redirect!
    assert_response :success
    assert_select "input#user_first_name[value=?]", "#{ @new_user.first_name }"
    assert_select "input#user_last_name[value=?]", "#{ @new_user.last_name }"
  end

  test "should be able to update email" do
    sign_in(@existing_user)
    patch edit_user_url, params: { user: {
      email: @new_user.email,
      current_password: @existing_user.password } }

    email_body = ActionMailer::Base.deliveries.first.body.to_s
    confirmation_link = (URI.extract(email_body)).first

    sign_in(@existing_user)
    get confirmation_link
    get settings_url
    assert_response :success
    assert_select "input#user_email[value=?]", "#{ @new_user.email }"
  end

  test "shoud be able to delete account" do
    sign_in(@existing_user)
    delete delete_account_url
    assert_redirected_to signin_url
    follow_redirect!
    assert_response :success
  end

  test "should see gravatar if exists" do
    sign_in(@existing_user_with_gravatar)
    get root_url
    assert_select "a#settings-button" do
      assert_select "img[alt=#{@existing_user_with_gravatar.first_name}]"
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

  test "should be unauthorized when trying to update data signed out" do
    patch edit_user_url(@existing_user), params: { user: { email: "test@example.com" } }
    assert_response :unauthorized
  end

  test "should be redirected to signin page when trying to delete data signed out" do
    delete delete_account_url(@existing_user)
    assert_response :unauthorized
  end

end