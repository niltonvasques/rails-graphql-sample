source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Enable cors requests
gem 'rack-cors'

# GraphQL
gem 'graphql'

gem 'acts_as_commentable'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Pretty print ruby types
gem 'awesome_print'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Use RSpec for specs
  gem 'rspec-rails', '>= 3.5.0'
  gem 'rspec-collection_matchers'

  # Use Factory Girl for generating random test data
  gem 'factory_girl_rails'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'rspec-mocks' # for rspec-mocks only
  gem 'database_cleaner', '~> 1.5.3'

  # Test coverage gems
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Generate Data Model diagram
  gem 'rails-erd'

  gem 'pronto'
  gem 'pronto-flay', require: false # Analyze code replication
  gem 'pronto-rubocop', require: false # Analyze code style and bad smells
  gem 'pronto-brakeman', require: false # Analyze security issues
  gem 'pronto-fasterer', require: false # Analyze performance issues
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
