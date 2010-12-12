class Retailer < ActiveRecord::Base
  
  def full_address
    self.street_address + ', ' + self.zipcode
  end
end
