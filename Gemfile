# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'blueprinter', '~> 0.25'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dry-validation', '~> 1.6'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sass-rails', '>= 6'
gem 'sqlite3', '~> 1.4'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 3.35'
  gem 'dotenv-rails', '~> 2.7'
  gem 'factory_bot', '~> 6.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'pry', '~> 0.13.0'
  gem 'pry-byebug', '~> 3.9'
  gem 'rspec-rails', '~> 5.0'
  gem 'rswag-specs'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', '~> 1.18', require: false
  gem 'rubocop-performance', '~> 1.11', require: false
  gem 'rubocop-rails', '~> 2.11', require: false
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webmock', '~> 3.13'
end
