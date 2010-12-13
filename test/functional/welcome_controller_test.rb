require 'test_helper'
require 'geocoder'

class WelcomeControllerTest < ActionController::TestCase

  def setup
    @google_full_hash = {:street_address=>"100 Spear St", :city=>"San Francisco", :state=>"CA", :zip=>"94105", :country_code=>"US", :lng => -96.958444, :lat => 32.918593}
    @google_full_loc = Geokit::GeoLoc.new(@google_full_hash)
    Geokit::Geocoders::GoogleGeocoder.stubs(:geocode).returns(@google_full_loc)
  end
   
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test 'should create an user based on its geolocation' do
    params = {:longitude => -96.958444, :latitude => 32.918593, :name => 'test user'}
    post :html_localization, params
    assert_redirected_to :controller => :retailers
    assert_equal 'User saved with success', flash[:notice]
  end
  
  test 'should create an user based on its address and zipcode' do
     params = {:localization => {:address => "100 Spear St", :zipcode => "94105", :name => 'test user'}}
     post :user_localization, params
     assert_redirected_to :controller => :retailers
     assert_equal 'User saved with success', flash[:notice]
   end

end
