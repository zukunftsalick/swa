class QueriesController < ApplicationController
  def index
    user = User.find_by_ip(cookies['user_ip'])
    
    if user.nil?
      flash[:error] = "Please: you need to find yourself a location."
      redirect_to :controller => :welcome, :action => :index
      return
    end
    
    @queries = Query.find_all_by_user_id(user.id)
  end
end
