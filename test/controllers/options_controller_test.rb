require "test_helper"

class OptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get options_new_url
    assert_response :success
  end
end
