require 'rails_helper'

describe 'Theme' do
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
			expect(theme.changed?).to eq true 

			theme.save 

			expect(theme.name).to eq "My theme name"
			expect(theme.changed?).to eq false 
		end
	end

end