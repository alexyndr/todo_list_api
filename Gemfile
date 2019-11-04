# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'active_storage_validations'
gem 'acts_as_list' # sorting and reordering a number of objects in a list
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise_token_auth'
gem 'fast_jsonapi' # serializer for json
gem 'pg'
gem 'puma', '~> 3.11'
gem 'pundit' # authorization
gem 'rack-cors' # to read
gem 'rails', '~> 6.0.0'
gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  gem 'fasterer'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'dox', require: false
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'json_matchers'
  gem 'pundit-matchers'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
