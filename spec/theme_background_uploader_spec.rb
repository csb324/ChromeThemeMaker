require 'rails_helper'
require 'carrierwave/test/matchers'

describe ThemeBackgroundUploader do 	
  include CarrierWave::Test::Matchers

  before do
  	path_to_file = "spec/bear.jpeg"
    ThemeBackgroundUploader.enable_processing = true
    @uploader = ThemeBackgroundUploader.new(@theme, :theme_background)

    File.open(path_to_file) do |f|
      @uploader.store!(f)
    end
  end

  after do
    ThemeBackgroundUploader.enable_processing = false
    @uploader.remove!
  end  

  context 'the full version' do 
  	it "should not be larger than 2000px wide or tall" do 
  		expect(@uploader).to be_no_larger_than(2000, 2000)
  	end
  end

  context 'the toolbar version' do 
  	it "should be exactly 2000x200" do 
  		expect(@uploader.toolbar).to have_dimensions(2000, 200)
  	end
  end
  context 'the frame version' do 
  	it "should be exactly 2000x100" do 
  		expect(@uploader.frame).to have_dimensions(2000, 100)
  	end
  end

end