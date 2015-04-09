CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.production?
    config.storage = :fog
    config.fog_directory = ENV['s3_directory']
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['s3_access_key_id'],
      aws_secret_access_key: ENV['s3_secret_access_key'],
      region: ENV['s3_region'],
    }
  else
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end
end
