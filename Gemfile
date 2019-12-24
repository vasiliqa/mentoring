source 'https://rubygems.org'

gem 'rails', '5.1.4'
gem 'pg', '~> 0.21'

gem 'aasm'
gem 'active_link_to', '>= 1.0.5'
gem 'bxslider-rails'
gem 'cancancan'
gem 'cocoon'
gem 'coffee-rails', '>= 4.2.2'
gem 'devise', '>= 4.7.1'
gem 'dotenv-rails' , '>= 2.6.0' # ...load environment variables from `.env`
gem 'dropzonejs-rails', '>= 0.8.4'
gem 'jbuilder'
gem 'jquery-datetimepicker-rails'
gem 'jquery-rails', '>= 4.3.4'
gem 'jquery-turbolinks', '>= 2.1.0'
gem 'kaminari', '>= 1.1.1'
gem 'mailboxer', '>= 0.15.1'
gem 'paperclip'
gem 'public_activity', '>= 1.6.3'
gem 'puma', '>= 3.12.2'
gem 'rack-attack', '>= 5.4.2'
gem 'rails_admin', '>= 1.4.2'
gem 'rolify'
gem 'rollbar'
gem 'sass-rails', '>= 5.0.7'
gem 'sdoc', group: :doc
gem 'semantic-ui-sass'
gem 'sidekiq', '5.0.5'
gem 'slim-rails', '>= 3.2.0'
gem 'switch_user'
gem 'turbolinks'
gem 'uglifier'

# fix for https://github.com/net-ssh/net-ssh/issues/565:
gem 'ed25519'
gem 'bcrypt_pbkdf'

group :development do
  gem 'annotate'
  gem 'awesome_print'
  gem 'spring'

  # Deployments stuff
  gem 'capistrano', '3.10.0', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', '>= 1.0.2', require: false
  gem 'capistrano3-puma', '>= 3.1.1', require: false
end

group :development, :test do
  gem 'factory_bot_rails', '>= 5.0.0', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-mocks'
  gem 'rspec-rails', '>= 3.8.2'
end

group :test do
  gem 'capybara', '>= 3.13.2'
  gem 'coveralls', require: false
  gem 'cucumber-rails', '>= 1.6.0', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'rails-controller-testing', '>= 1.0.4'
  gem 'selenium-webdriver', '>= 3.141.0'
  gem 'simplecov', require: false
end
