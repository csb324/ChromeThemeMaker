class AddManifestDataToThemes < ActiveRecord::Migration
  def change
  	change_table :themes do |t|
  		t.string :frame_color
  		t.string :toolbar_color
  		t.string :tab_text_color
  		t.string :bookmark_text_color
  		t.string :ntp_background_color
  		t.string :ntp_text_color
  		t.string :button_background_color
  		t.string :button_color
  		t.string :ntp_background_alignment 
  		t.string :ntp_background_repeat 
  	end
  end
end
