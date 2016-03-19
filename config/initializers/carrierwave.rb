CarrierWave.configure do |config|

	config.storage = :aws
	config.aws_bucket = Rails.application.secrets.s3_bucket_name
  config.aws_acl    = 'public-read'

  config.aws_credentials = {
    access_key_id:     Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region:            Rails.application.secrets.aws_region
  }
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end