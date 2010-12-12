require 'test_helper'
require 'geocoder'

class GeocoderTest < ActiveSupport::TestCase
  
  setup do
    FakeWeb.register_uri(:get, %r|http://maps.google.com/maps/geo|, :body => geocode_xml_response(200))
  end
  
  test 'should retrieve geolocation info from a given correct street addres and zipcode' do
    geocoder = Geocoder.new("1600 Amphitheatre, 94043") 
    assert_not_nil geocoder.location
  end
  
  test 'should set location to nil when retrieving geolocation info from a incorrect street addres and zipcode' do
    FakeWeb.register_uri(:get, %r|http://maps.google.com/maps/geo|, :body => geocode_xml_response(300))
    geocoder = Geocoder.new("12323 Amphitheatre, 0000000122002") 
    assert_nil geocoder.location
  end
  
  test 'should calculate distance between two locations' do
    Graticule::Distance::Haversine.stubs(:distance).returns(0.388360591880299)
    geocoder = Geocoder.new("1600 Amphitheatre parkway, 94043")
    assert_equal 0.388360591880299, geocoder.distance_to('900 Amphitheatre parkway, 94043')
  end

  def geocode_xml_response(code = 200)
    <<-STR
    <kml xmlns="http://earth.google.com/kml/2.0">
      <Response>
        <name>1600 amphitheatre mountain view ca</name>
        <Status>
          <code>#{code}</code>
          <request>geocode</request>
        </Status>
        <Placemark>
          <address> 
            1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA
          </address>
          <AddressDetails Accuracy="8">
            <Country>
              <CountryNameCode>US</CountryNameCode>
              <AdministrativeArea>
                <AdministrativeAreaName>CA</AdministrativeAreaName>
               <SubAdministrativeArea>
                 <SubAdministrativeAreaName>Santa Clara</SubAdministrativeAreaName>
                 <Locality>
                   <LocalityName>Mountain View</LocalityName>
                   <Thoroughfare>
                     <ThoroughfareName>1600 Amphitheatre Pkwy</ThoroughfareName>
                   </Thoroughfare>
                   <PostalCode>
                     <PostalCodeNumber>94043</PostalCodeNumber>
                   </PostalCode>
                 </Locality>
               </SubAdministrativeArea>
             </AdministrativeArea>
           </Country>
         </AddressDetails>
         <Point>
           <coordinates>-122.083739,37.423021,0</coordinates>
         </Point>
       </Placemark>
      </Response>
    </kml>
    STR
  end
end