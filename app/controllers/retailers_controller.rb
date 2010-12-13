class RetailersController < ApplicationController
  
  def index
    @retailers = Retailer.all
  end
  
  def search
    retailer = Retailer.find(:first, :conditions => ["name LIKE (?)", '%'+params[:query][:query_term]+'%'])

    if retailer.nil?
      flash[:error] = 'Your search returned zero results.'
      redirect_to :controller => :retailers,  :action => :index
      return
    end
    
    user = User.find_by_ip(cookies[:user_ip])
    @query = Query.find_or_create_by_user_id_and_query_term(
        :user_id => user.id,
        :destination_address => retailer.full_address,
        :distance => Geocoder.new(user.latlng).location.distance_to(retailer.full_address),
        :query_term => params[:query][:query_term],
        :retailer_id => retailer.id
    )
  end
end
