class Retailer < ActiveRecord::Base
  has_many :queries
  def full_address
    street_address + ', ' + zipcode
  end
end
