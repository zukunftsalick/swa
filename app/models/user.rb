class User < ActiveRecord::Base
  has_many :queries
  def self.localize_by_coords(params)
    geocoder = Geocoder.new("#{params[:latitude]}, #{params[:longitude]}")
    User.find_or_create_by_ip(
      :address => geocoder.location.street_address, 
      :zipcode => geocoder.location.zip,
      :lat => geocoder.location.lat,
      :lng => geocoder.location.lng,
      :ip => params[:ip]
      )
  end
  
  def self.localize_by_address(params)
    geocoder = Geocoder.new("#{params[:localization][:address]}, #{params[:localization][:zipcode]}")
    User.find_or_create_by_ip(
      :address => geocoder.location.street_address, 
      :zipcode => geocoder.location.zip,
      :lat => geocoder.location.lat,
      :lng => geocoder.location.lng,
      :ip => params[:ip]
    )
  end
  
  def latlng
    "#{lat}, #{lng}"
  end
end
