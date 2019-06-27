Rails.application.routes.draw do
 
	#Routes para match
	resources :matches do
  		member do
    		get 'add_match', 'play'
  		end
	end
	

	#routes for devise for players   
	devise_for :players

	devise_scope :player do
		#Si el usuario inicio sesion
  		authenticated :player do
    		root :to => 'matches#front', as: :authenticated_root
  		end
  		#Si el usuario no inicio sesion
	  	unauthenticated :player do
	    	root :to => 'devise/sessions#new', as: :unauthenticated_root
	  	end
	end


	#routes for numbers
	resources :numbers 
	get 'numbers/new'
	post 'numbers/create'
	post 'numbers/new_play_number'
end
