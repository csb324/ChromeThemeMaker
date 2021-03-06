# encoding: utf-8
class ThemeBackgroundUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def content_type_whitelist
    /image\//
  end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :resize_and_convert

  version :frame do 
    process resize_to_fill: [2000, 100, ::Magick::NorthGravity]
  end

  version :toolbar do 
    process :crop 
  end

  version :preview do 
    process :mask_chrome
  end


  def mask_chrome
    manipulate! do |img|
      img.resize_to_fit!(2000)
      img.crop!(0,0,2000, 1686)
      mask = Magick::Image.read("app/assets/images/chrome_mask.png").first

      img.composite!(mask, 0, 0, Magick::ScreenCompositeOp)
    end
  end

  def crop
    manipulate! do |img|
      img = img.crop(0, 200, 2000, 200)
    end
  end

  def resize_and_convert
    manipulate! do |img|
      img.format = 'JPEG'
      img.resize_to_fit!(2000, 2000)
    end
  end

  def filename
    super.chomp(File.extname(super)) + '.jpeg' if original_filename.present?
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  
  # def filename
  #   super.chomp(File.extname(super)) + '.png' if original_filename.present?
  # end
end
