class ArticlesControllerTest < ActionDispatch::IntegrationTest

  test "should get signup" do
    get signup_url
    assert_response :success
  end

  test "should get signin" do
    get signin_url
    assert_response :success
  end

  # test "should get index (signed out)" do
  #   get root_url
  #   assert_response :success
  # end

end