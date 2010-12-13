require 'test_helper'

class QueriesControllerTest < ActionController::TestCase
  test "should load queries list" do
    user = Factory(:user)
    User.expects(:find_by_ip).returns(user)
    Factory(:query)
    
    get :index
    assert_response :success
    assert assigns(:queries)
  end
  
  test "should redirect if user is nil" do
    User.expects(:find_by_ip).returns(nil)
    
    get :index
    assert_redirected_to :controller => :welcome, :action => :index
    assert_equal "Please: you need to find yourself a location.", flash[:error]
  end

end
