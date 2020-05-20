unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV[""],
      aws_secret_access_key: ENV[""],
      region: ENV[""]
    }
    
    config.fog_directory = ENV["rails-photo-chazuke"]
    config.cache_storage = :fog_credentials
  end
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end
