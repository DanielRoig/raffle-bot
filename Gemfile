source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.3'
# Use dotenv-rails to load environment vars
gem 'dotenv-rails', '~> 2.7.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Sidekiq Pro for even more awesome background processing.
gem 'sidekiq', '~> 5.2.9'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# TooTools for developing Telegram bots.
gem 'telegram-bot', '~> 0.15.5'
# A Ruby Library for dealing with money and currency conversion.
gem 'money'

group :development, :test do
  # Use Pry to debug
  gem 'pry-rails', '>= 0.3.9'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-rails'
  # Use rubocop to analyze code
  gem 'rubocop', '~> 1.7.0', require: false
  # Use rubocop-performance to find possible performance optimizations
  gem 'rubocop-performance', require: false
  # Use RSpec to test
  gem 'rspec-rails', '~> 4.0'
  # Use Factory Bot to fixture replacement
  gem 'factory_bot_rails'
  # Use SimpleCov to test coverage
  gem 'simplecov', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
end

group :test do
  # Use ShouldaMatchers to extend testing matchers collection
  gem 'shoulda-matchers', '~> 4.3.0'
  # Use rspec-JsonExpectations to add Json matchers to testing collection.
  gem 'rspec-json_expectations'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
