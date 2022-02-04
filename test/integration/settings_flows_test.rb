require "test_helper"

class SettingsFlowsTest < ActionDispatch::IntegrationTest

  setup do
    @user = build :user
  end

  teardown do
    @user = nil
  end

end