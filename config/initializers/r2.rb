require 'aws-sdk-s3'

# Load R2 configuration
r2_config = Rails.application.config_for(:r2_config)

# Initialize R2 client
R2_CLIENT = Aws::S3::Client.new(
  access_key_id: r2_config.dig(:cloudflare_r2, :access_key_id),
  secret_access_key: r2_config.dig(:cloudflare_r2, :secret_access_key),
  region: 'auto',
  endpoint: r2_config.dig(:cloudflare_r2, :endpoint),
  force_path_style: true
)

# Store configuration globally
R2_CONFIG = r2_config[:cloudflare_r2]