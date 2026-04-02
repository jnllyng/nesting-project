require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get checkouts_new_url
    assert_response :success
  end

  test "should get create" do
    get checkouts_create_url
    assert_response :success
  end

  test "should get confirm" do
    get checkouts_confirm_url
    assert_response :success
  end
end
