# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'faraday'
gem 'jsonapi-rails'
gem 'kaminari'
gem 'mutations'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-doc'
  gem 'rubocop'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end