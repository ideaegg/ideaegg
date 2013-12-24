source 'https://rubygems.org'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end
def linux_only(require_as)
  RUBY_PLATFORM.include?('linux') && require_as
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do
  # Use PostgreSQL as the database for production
  gem 'pg'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Use bootstrap as the theme framework
gem 'bootstrap-sass'
group :development do
  gem 'rails_layout'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'fabrication'

  # Guard
  gem 'guard', '~> 2.2.5'
  gem 'guard-rspec', '~> 4.2.1', require: false
  gem 'spork-rails', '~> 4.0.0'
  gem 'guard-spork', '~> 1.5.1'

  # Test notification
  gem 'rb-fsevent', require: darwin_only('rb-fsevent')
  gem 'growl',      require: darwin_only('growl')
  gem 'rb-inotify', require: linux_only('rb-inotify')
end

# deploy on heroku.com
gem 'rails_12factor', group: :production
