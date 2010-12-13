require 'test_helper'
require 'geocoder'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @google_full_hash = {:street_address=>"100 Spear St", :city=>"San Francisco", :state=>"CA", :zip=>"94105", :country_code=>"US", :lng => -96.958444, :lat => 32.918593}
    @google_full_loc = Geokit::GeoLoc.new(@google_full_hash)
    Geokit::Geocoders::GoogleGeocoder.stubs(:geocode).returns(@google_full_loc)
  end
  
  test 'should find the location for a user by its coordinates(lat,lng)' do
    params = {:longitude => -96.958444, :latitude => 32.918593, :name => 'test user'}
    
    user   = User.localize_by_coords(params)
    assert_not_nil user
    assert_equal 32.918593, user.lat
    assert_equal -96.958444, user.lng
  end
  
  test 'should find the location for a user by its address with zipcode' do
    params = {:localization => {:address => "100 Spear St", :zipcode => "94105", :name => 'test user'}}
    
    user   = User.localize_by_address(params)
    assert_not_nil user
    assert_equal 32.918593, user.lat
    assert_equal -96.958444, user.lng
    assert_equal '100 Spear St', user.address
    assert_equal '94105', user.zipcode 
  end
  
  test "should retrive an user's coordinates" do
    Factory(:user)
    assert_equal "40.719551, -74.042122", User.first.latlng
  end
end
