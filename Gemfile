source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# for heroku Deploy
group :production do
  gem 'pg'
  gem 'execjs'
  gem 'therubyracer'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml'
gem 'builder'

# markdown parser
gem 'rdiscount'

# enable code highlighting
gem 'coderay'

gem 'erb2haml', :group => :development
gem 'compass', "~> 0.12.alpha.3"

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :test, :development do
  gem 'rspec-rails', ">= 2.0.1"
end
