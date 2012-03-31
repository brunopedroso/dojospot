source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'RedCloth'
gem 'pg', :group=>:production
gem 'newrelic_rpm'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'cucumber-rails'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'minitest', '2.11.3'
  gem 'factory_girl', :group=>:development
  gem "rspec-rails", "~> 2.6"
  gem 'spork'
  gem 'guard-spork'
  gem 'shoulda'
  gem 'webrat'
end

gem "nifty-generators", :group => :development
gem "bcrypt-ruby", :require => "bcrypt"
gem "mocha", :group => :test
