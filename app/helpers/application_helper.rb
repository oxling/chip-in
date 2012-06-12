require 'authentication.rb'
module ApplicationHelper
	include ::Authentication	
	
	def anyone_logged_in?
		if session[:user_id] != nil and User.exists?(session[:user_id])
			return true
		else
			return false
		end
	end

end
