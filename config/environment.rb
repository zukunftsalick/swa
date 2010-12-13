# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Swa::Application.initialize!

require 'geokit'
require 'geocoder'
Geokit::Geocoders::google = {'localhost:3000' => GOOGLE_MAPS_API_KEY}