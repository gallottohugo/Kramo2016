class NumbersController < ApplicationController
	#before_filter :find_model
	
	def index
		@numbers = current_player.numbers
		@email = current_player.email
	end

	def new
		match_id = params[:match] 
		@match = Match.find(match_id)

		@number = current_player.numbers.build

		@max_length = params[:lenght]
	end

	def show 
		@number = Number.find(params[:id])
	end

	def create	
		if params[:number][:player_number] == "true" then #Esto va para que identifique si es el numero principal de la partida
			new_number = Number.new(:number => params[:number][:number], 
									:match_id => params[:number][:match_id].to_i, 
									:player_id => current_player.id, 
									:player_number => true)
		end
		if new_number.save then

			#estas validaciones son para enviar a play y ver los resultados
			@equals = new_number.validation_equals
			@regulars = new_number.validation_regular

			redirect_to "/matches/#{new_number.match_id}/play"
		else
			flash[:notice] = "Ocurrio un error al grabar los datos"
			redirect_to "/numbers/new"
		end
	end





	def new_play_number
		new_number = Number.new(:number => params[:number], 
					:match_id => params[:match].to_i, 
					:player_id => current_player.id, 
					:player_number => false)
		if new_number.save then
			render :status => 100
		else
			render :status => 401
		end      
	end




end

