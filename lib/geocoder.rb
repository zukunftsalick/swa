class Geocoder
  def initialize(address)
    @geocoder = Geokit::Geocoders::GoogleGeocoder.geocode(address)
  end
  
  def location
    @geocoder
  end
  
  def distance_to(address)
    puts address
    @geocoder.distance_to(Geokit::Geocoders::GoogleGeocoder.geocode(address))
  end
end
