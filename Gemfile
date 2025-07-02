source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 7.1.3'
gem 'sprockets-rails', '~> 3.4'
gem 'sqlite3', '~> 1.6.5'
gem 'puma', '~> 6.4.2'
gem 'importmap-rails', '~> 1.2'
gem 'turbo-rails', '~> 1.5'
gem 'stimulus-rails', '~> 1.3'
gem 'jbuilder', '~> 2.11'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false

group :development, :test do
  gem 'rspec-rails', '~> 6.1.1'
  gem 'factory_bot_rails', '~> 6.3'
  gem 'faker', '~> 3.2'
  gem 'shoulda-matchers', '~> 5.3'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'byebug', '~> 9.0'
end

group :development do
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'rspec', '~> 3.12'
  gem 'capybara', '~> 3.39'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
