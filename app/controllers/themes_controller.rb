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
			redirect_to edit_theme_path(@theme)
		else
			flash.now[:alert] = "There was a problem!"
			render :new
		end
	end

	def edit
		@theme = Theme.find(params[:id])
	end

	def update
		@theme = Theme.find(params[:id])
	end

	def download
		@theme = Theme.find(params[:id])		
		zip_data = @theme.create_zip
	  send_data(zip_data, :type => 'application/zip', :filename => "theme.zip")
	end

	def destroy
		@theme = Theme.find(params[:id])
		@theme.destroy 
		redirect_to themes_path
	end

	private
	def theme_params 
		params.require(:theme).permit(:name, :theme_background)
	end

end
