source 'https://rubygems.org'

# Define lowest version of bundler
gem 'bundler', '>= 1.8.4'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Form wizard
gem 'wicked'

# Form upload helper
gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'

# Drag and grop js support
gem 'dropzonejs-rails'

# SQL Server support
gem 'tiny_tds'
gem 'activerecord-sqlserver-adapter', '~> 4.2'

# Authentication frameworks
gem 'devise'
gem 'omniauth-ldap'

# Job queue
gem 'sidekiq'

# Combine PDF
gem 'combine_pdf'

# Paginate results
gem 'kaminari'

# Redis cache
gem 'redis-rails', '~> 4'

# Puma webserver for live-streaming
gem 'puma'

# Rails Assets for frontend frameworks
source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '~> 3.3.7'
end

group :production do
  # Use mysql2 as the database for Active Record
  gem 'mysql2', '~> 0.3.18'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

