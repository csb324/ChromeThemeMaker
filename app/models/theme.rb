require 'zip'
require 'open-uri'

class Theme < ActiveRecord::Base

  belongs_to :user 
  mount_uploader :theme_background, ThemeBackgroundUploader

  def create_zip

    filename = 'chrome-theme-'+name+'.zip'
    temp_file = Tempfile.new(filename)
    manifest = Tempfile.new("manifest.json")
    manifest.write(create_manifest)
    manifest.rewind

    frame = open(URI.encode(theme_background.frame.url))
    toolbar = open(URI.encode(theme_background.toolbar.url))
    begin
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        zip.add("manifest.json", manifest)
        zip.add("images/theme_frame.jpeg", frame)
        zip.add("images/theme_toolbar.jpeg", toolbar)
      end
      zip_data = File.read(temp_file.path)
      return zip_data
    ensure 
      manifest.close
      manifest.unlink

      temp_file.close
      temp_file.unlink
    end
  end  

  private

  def create_manifest 
    manifest = ""
    manifest += '{
      "manifest_version":2,
      "theme":{
        "images":{
          "theme_frame": "images\/theme_frame.jpeg",
          "theme_toolbar":"images\/theme_toolbar.jpeg"
        },
        "colors":{
          "bookmark_text":[0, 0, 0],
          "toolbar":[255, 255, 255], // background of corner-box when you hover over a link
          "tab_text":[0, 0, 0], // ACTIVE tab text
          "tab_background_text":[0, 0, 0], // INACTIVE tab text
          "frame":[0, 0, 0], // not clear?
          "ntp_background":[0,0,255], // new-tab window bg
          "ntp_section_header_rule": [0, 0, 0],
          "ntp_text":[0, 0, 0],
          "ntp_section": [0, 0, 0], 
          "ntp_link": [0, 0, 0],
          "ntp_section_header_text": [0, 0, 0],
          "button_background":[0,0,0,1],
          "status_bar_text": [255, 255, 255]
        },
        "tints":{
          "buttons":[20, 0, 50] // still not sure
        },
        "properties":{
          "ntp_background_alignment":"bottom",
          "ntp_background_repeat":"no-repeat"
        }
      },
      "name":"'
    manifest += name 
    manifest += '",
      "version":"1",
      "description":""
    }'

    manifest
  end

end
