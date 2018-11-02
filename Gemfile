source 'https://rubygems.org'

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'pg'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.1.3'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'friendly_id'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.11'
gem 'redis', require: false
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'guard'
  gem 'guard-cucumber'
  gem 'guard-rspec'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rails_config'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.7'
  gem 'chromedriver-helper'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
  gem 'rails-controller-testing' # If you are using Rails 5.x
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'simplecov', require: false
end
