require "test_helper"

class Api::PositionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_positions_index_url
    assert_response :success
  end
end
