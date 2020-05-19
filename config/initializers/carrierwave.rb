unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["AKIA4IY7YPUCAINIS3X3"],
      aws_secret_access_key: ENV["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"],
      region: ENV["ap-northeast-1"]
    }
    
    config.fog_directory = ENV["rails-photo-chazuke"]
    config.cache_storage = :fog_credentials
  end
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end