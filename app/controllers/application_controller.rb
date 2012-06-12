require 'authentication.rb'

class ApplicationController < ActionController::Base
  include ::Authentication
  protect_from_forgery
  
  def login_required
  	
  	unless session[:user_id] == nil
  		return true
  	end
  	
  	redirect_to login_users_path	
  	return false
  	
  end
    
end
