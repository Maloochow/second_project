source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun'
gem 'bcrypt'
gem 'tux'
gem 'materialize-sass'
gem 'dotenv'
gem 'rack-flash3'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :development, :test do
  gem 'pry'
  gem 'sqlite3', '~> 1.3.6'
end

group :production do
  gem 'pg'
end