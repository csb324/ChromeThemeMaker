class ThemesBelongToUsers < ActiveRecord::Migration
  def change
  	change_table :themes do |t|
  		t.references :user, null: false 
  	end
  end
end
