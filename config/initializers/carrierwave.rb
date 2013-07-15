  if File.exists?(File.join(Rails.root, 'config', 'amazon.yml')) && !Rails.env.production?
    AMAZON_CONFIG = YAML.load_file(File.join(Rails.root, 'config', 'amazon.yml'))
    ENV['S3_KEY'] = AMAZON_CONFIG["s3_key"]
    ENV['S3_SECRET'] = AMAZON_CONFIG["s3_secret"]
    ENV['S3_REGION'] = AMAZON_CONFIG["s3_region"]
    ENV['S3_BUCKET_NAME'] = AMAZON_CONFIG["s3_bucket_name"]
  end

CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"

  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                # required
      :aws_secret_access_key  => ENV['S3_SECRET'],             # required
      :region                 => ENV['S3_REGION']               # optional, defaults to 'us-east-1'
      #:host                   => 's3.example.com',             # optional, defaults to nil
      #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']                   # required
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    #config.fog_public     = false                                   # optional, defaults to true
    #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end

end
