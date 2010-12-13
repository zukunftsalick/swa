class WelcomeController < ApplicationController
  def index
  end
  
  def html_localization
    user = User.localize_by_coords(params.merge(:ip => cookies[:user_ip]))
    redirect_user(user)
  end
  
  def user_localization
    user = User.localize_by_address(params.merge(:ip => cookies[:user_ip]))
    redirect_user(user)
  end
  
  def redirect_user(user)
    if user.save
      flash[:notice] = 'User saved with success'
      redirect_to :retailers
    else
      flash[:error] = 'There was a problem saving your location. Please try again.'
      redirect_to :controller => "welcome", :action => "index"
    end
  end
  private :redirect_user
end
