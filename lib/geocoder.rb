require 'graticule'
class Geocoder
  def initialize(address)
    @geocoder = Graticule.service(:google).new(GOOGLE_MAPS_API_KEY)
    begin
      @location = @geocoder.locate(address)
    rescue Exception
      @location = nil
    end
  end
  
  def location
    @location
  end
  
  def distance_to(address)
    @location.distance_to(@geocoder.locate(address))
  end
end
