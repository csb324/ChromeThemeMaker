require 'rails_helper'

RSpec.describe Theme, '#index' do
	before(:each) do
	  @user = User.new(email: "fake@fake.com", password: "fakepassword")
	  @user.save
	end

	context "when the user has not created a theme" do 
		it "A theme is created with no name" do 
			theme = Theme.new(user: @user)
			theme.save
			expect(theme.name).to eq ""
		end
	end	

	context "when it's given a name" do 
		it "saves the name" do 
			theme = Theme.new(user: @user)
			theme.save 

			theme.name = "My theme name"
			theme.save 

			expect(theme.name).to eq "My theme name"
			expect(theme.changed?).to eq false 
		end
	end

end