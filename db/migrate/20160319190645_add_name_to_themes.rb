class AddNameToThemes < ActiveRecord::Migration
  def change
  	change_table :themes do |t|
  		t.string :name, default: ""
  	end
  end
end
