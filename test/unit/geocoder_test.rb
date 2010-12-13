require 'test_helper'
require 'geocoder'

Geokit::Geocoders::google = 'Google'

class GeocoderTest < ActiveSupport::TestCase
  GOOGLE_FULL=<<-EOF.strip
  <?xml version="1.0" encoding="UTF-8"?><kml xmlns="http://earth.google.com/kml/2.0"><Response><name>100 spear st, san francisco, ca</name><Status><code>200</code><request>geocode</request></Status><Placemark><address>100 Spear St, San Francisco, CA 94105, USA</address><AddressDetails Accuracy="8" xmlns="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"><Country><CountryNameCode>US</CountryNameCode><AdministrativeArea><AdministrativeAreaName>CA</AdministrativeAreaName><SubAdministrativeArea><SubAdministrativeAreaName>San Francisco</SubAdministrativeAreaName><Locality><LocalityName>San Francisco</LocalityName><Thoroughfare><ThoroughfareName>100 Spear St</ThoroughfareName></Thoroughfare><PostalCode><PostalCodeNumber>94105</PostalCodeNumber></PostalCode></Locality></SubAdministrativeArea></AdministrativeArea></Country></AddressDetails><Point><coordinates>-96.958444, 32.918593,0</coordinates></Point></Placemark></Response></kml>
  EOF
  
 def setup
   @address = 'San Francisco, 94105-1522'    
  
   @latlng = Geokit::LatLng.new(37.7742, -122.417068)
   @success = Geokit::GeoLoc.new({:city=>"SAN FRANCISCO", :state=>"CA", :country_code=>"US", :lat=>@latlng.lat, :lng=>@latlng.lng})
   @success.success = true
   
   @loc_a = Geokit::LatLng.new(32.918593,-96.958444)
   @loc_e = Geokit::LatLng.new(32.969527,-96.990159)
   @point = Geokit::LatLng.new(@loc_a.lat, @loc_a.lng)
 end
  
  test 'should retrieve geolocation info from a given correct street addres and zipcode' do
    response = MockSuccess.new
    response.expects(:body).returns(GOOGLE_FULL)
    url = "http://maps.google.com/maps/geo?q=#{Geokit::Inflector.url_escape(@address)}&output=xml&key=Google&oe=utf-8"
    Geokit::Geocoders::GoogleGeocoder.expects(:call_geocoder_service).with(url).returns(response)
    
    geocoder = Geocoder.new(@address) 
    assert_not_nil geocoder.location
  end
  
  test 'should calculate distance between two locations' do
    response = MockSuccess.new
    response.expects(:body).returns(GOOGLE_FULL)
    url = "http://maps.google.com/maps/geo?q=#{Geokit::Inflector.url_escape(@loc_a.ll)}&output=xml&key=Google&oe=utf-8"
    Geokit::Geocoders::GoogleGeocoder.expects(:call_geocoder_service).with(url).returns(response)
    
    geocoder = Geocoder.new(@loc_a.ll)
    assert_in_delta 3.97, Geokit::LatLng.distance_between(@loc_a, @loc_e), 0.01
    assert_in_delta 3.97, geocoder.location.distance_to(@loc_e.ll), 0.01
  end
end