class MatchesController < ApplicationController

	def index
		@matches = UserMatch.joins(:match).where("vs_player = ? and available = ? and player_id != ?", true, true, current_player.id)
	end

	def new
		@match = Match.new
	end

	def create
		new_match = Match.create(
				:name => params[:match][:name],
			  	:vs_machine => params[:match][:vs_machine],
			  	:vs_player => params[:match][:vs_player],
			  	:available => true)

		UserMatch.create(
				:player_id => current_player.id,
				:match_id => new_match.id)
		
		#Number.create (
		#		:player_id => current_player.id,
		#		:number => current_player.id,
		#		:match_id => new_match.id,
		#		:player_number => true
		#		)



		#cuando voy al new de numbers envio el numero de partida
		redirect_to "/numbers/new?match=#{new_match.id}&lenght=#{params[:lenght]}"
	end


	def show
		@user_match = UserMatch.where("match_id = ?", params[:id]).first
	end


	def add_match
		match = Match.find(params[:id])
		match.available = false
		match.save

		UserMatch.create(
				:player_id => current_player.id,
				:match_id => params[:id])

		redirect_to "/numbers/new?match=#{params[:id]}"
	end

	def play

		@num_current_user = Number.where("match_id = ? and player_number = ? and player_id = ?", params[:id], true, current_player.id).first.number
		@current_match = params[:id]
	end

end