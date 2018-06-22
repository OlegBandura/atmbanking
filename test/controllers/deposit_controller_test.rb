require 'test_helper'

class DepositControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get deposit_new_url
    assert_response :success
  end

end
