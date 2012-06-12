module Authentication
	
	def current_user
		
		id = session[:user_id]
  	if id and User.exists?(id)
  	  	user = User.find(id)
  	  	return user
  	end
  	return nil
  	
	end
	
	def set_user_session(id)
		session[:user_id] = id
	end
	 
end