require "test_helper"

class AssessmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get assessments_new_url
    assert_response :success
  end
end
