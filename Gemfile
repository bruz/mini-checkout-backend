source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.8'
gem 'hanami-model', '~> 0.6'
gem 'pg'

# CORS
gem 'rack-cors'

# API
gem 'roar'
gem 'multi_json'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/applications/code-reloading
  gem 'shotgun'
end

group :test, :development do
  # Config from .env files
  gem 'dotenv', '~> 2.0'

  # Debugging
  gem 'byebug'
  gem 'pry'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
