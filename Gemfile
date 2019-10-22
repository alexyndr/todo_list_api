source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.0'
gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false
gem 'pg'
gem 'puma', '~> 3.11'
gem 'acts_as_list' # sorting and reordering a number of objects in a list
gem 'fast_jsonapi' # serializer for json
gem 'rack-cors' # to read
gem 'pundit' # authorization
gem 'devise_token_auth'
gem 'rswag'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
end

group :development do
  gem 'fasterer'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rspec-rails', '~> 4.0.0.beta2'
end

group :test do
  gem 'database_cleaner'
  gem 'dox', require: false
  gem 'capybara', '>= 2.15'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'json_matchers'
  gem 'pundit-matchers'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'rspec_junit_formatter'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
