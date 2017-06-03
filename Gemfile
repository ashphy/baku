# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.1'

# Use Mysql as the database for Active Record

gem 'composite_primary_keys', '~> 9.0'
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Authentication and Authorization
gem 'devise'
gem 'devise_ldap_authenticatable'
gem 'pundit'

gem 'groupdate'
gem 'kaminari'
gem 'ransack'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '4.0.0.alpha.4'
  gem 'rails-assets-tether'
end
gem 'font-awesome-rails'

# for IRC Logger
gem 'cinch'
gem 'daemon-spawn', require: 'daemon_spawn'
gem 'settingslogic'

# for admin tools
gem 'awesome_print'

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'meta_request'
  gem 'rubocop', require: false
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
