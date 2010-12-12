require 'test_helper'

class RetailersControllerTest < ActionController::TestCase
  test "should load retailers index page" do
    Factory(:retailer_1)
    get :index
    assert assigns(:retailers)
    assert_not_nil assigns(:retailers)
    assert_response :success
  end
end
