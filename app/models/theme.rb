class Theme < ActiveRecord::Base
	belongs_to :user 
	mount_uploader :theme_background, ThemeBackgroundUploader

	
	
end
