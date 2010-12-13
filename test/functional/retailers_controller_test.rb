require 'test_helper'

class RetailersControllerTest < ActionController::TestCase
  GOOGLE_FULL=<<-EOF.strip
  <?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0"><Response><name>100 spear st, san francisco, ca</name><Status><code>200</code><request>geocode</request></Status><Placemark><address>100 Spear St, San Francisco, CA 94105, USA</address><AddressDetails Accuracy="8" xmlns="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"><Country><CountryNameCode>US</CountryNameCode><AdministrativeArea><AdministrativeAreaName>CA</AdministrativeAreaName><SubAdministrativeArea><SubAdministrativeAreaName>San Francisco</SubAdministrativeAreaName><Locality><LocalityName>San Francisco</LocalityName><Thoroughfare><ThoroughfareName>100 Spear St</ThoroughfareName></Thoroughfare><PostalCode><PostalCodeNumber>94105</PostalCodeNumber></PostalCode></Locality></SubAdministrativeArea></AdministrativeArea></Country></AddressDetails><Point><coordinates>-96.958444, 32.918593,0</coordinates></Point></Placemark></Response></kml>
  EOF
  
  test "should load retailers index page" do
    Factory(:retailer)
    get :index
    assert assigns(:retailers)
    assert_not_nil assigns(:retailers)
    assert_response :success
  end
  
  test "should search for store name" do
    retailer = Factory(:retailer)
    user = Factory(:user)
    User.expects(:find_by_ip).returns(user)
    request.cookies[:user_ip] = "127.0.0.1" #CGI::Cookie.new('user_ip', '127.0.0.1')

    params = {:query => {:query_term => retailer.name}}
    get :search, params
    assert_response :success
    assert assigns[:query]
  end
  
  test "should redirect in case of zero results" do
    retailer = Factory(:retailer)
    user = Factory(:user)
    User.expects(:find_by_ip).returns(user)
    request.cookies[:user_ip] = "127.0.0.1" #CGI::Cookie.new('user_ip', '127.0.0.1')

    params = {:query => {:query_term => 'blah'}}
    get :search, params
    assert_redirected_to :controller => :retailers, :action => :index
    assert_equal "Your search returned zero results.", flash[:error]
  end
end
