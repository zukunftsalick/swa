class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :user_info
  
  def user_info
    cookies[:user_ip] ||= request.env['REMOTE_ADDR']
  end
  private :user_info
end
