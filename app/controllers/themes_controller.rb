class ThemesController < ApplicationController

	before_action :authenticate_user!

	def index 
		@themes = Theme.all
	end

	def new 
		@theme = Theme.new(user: current_user)
	end

	def create 
		@theme = Theme.new(theme_params)
		@theme.user = current_user 

		if @theme.save
			redirect_to themes_path
		else 
			flash.now[:alert] = "There was a problem!"
			render :new
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def theme_params 
		params.require(:theme).permit(:name, :theme_background)
	end

end
