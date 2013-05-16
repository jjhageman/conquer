source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.13'

gem 'pg'
gem 'puma'
gem 'devise'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem 'debugger'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'vcr'
  gem 'fakeweb'
end
