class RetailersController < ApplicationController
  layout 'application'
  
  def index
    @retailers = Retailer.all
  end
end
