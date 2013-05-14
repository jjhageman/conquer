if File.exists?(File.join(Rails.root, 'config', 'stripe.yml')) && !Rails.env.production?
  STRIPE_CONFIG = YAML.load_file(File.join(Rails.root, 'config', 'stripe.yml'))
  ENV['STRIPE_PUBLIC_KEY'] = STRIPE_CONFIG["public_key"]
  ENV['STRIPE_API_KEY'] = STRIPE_CONFIG["api_key"]
end

STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY']
Stripe.api_key = ENV['STRIPE_API_KEY']
