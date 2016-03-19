class AddThemeBackgroundToThemes < ActiveRecord::Migration
  def change
  	change_table :themes do |t|
  		t.string :theme_background
  		t.string :theme_frame
  		t.string :theme_toolbar
  	end
  end
end
