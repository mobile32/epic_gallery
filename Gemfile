source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'devise'
gem 'carrierwave'
gem 'figaro'
gem 'jbuilder', '~> 2.5'
gem 'mini_magick'
gem 'omniauth-google-oauth2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pry-rails'
gem 'puma', '~> 3.7'
gem 'pundit'
gem 'rails', '~> 5.1.6'
gem "rails-patterns"
gem 'simple_form'
gem 'webpacker'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
