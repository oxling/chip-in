Fund::Application.routes.draw do
	root :to => "campaigns#index"
	
	resources :users do
		collection do
			get 'login'
			post 'login'
		end
		member do
			post 'logout'
		end
	end 
	
	resources :campaigns do
		resources :contributions
	end
	
end
