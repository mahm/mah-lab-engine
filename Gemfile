source 'http://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# for heroku Deploy
gem 'pg', group: :production
gem 'thin'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'zurui-sass-rails'
end

gem 'jquery-rails'
gem 'haml'
gem 'builder'

# markdown parser
gem 'rdiscount'

# enable code highlighting
gem 'coderay'

gem 'erb2haml', :group => :development
# gem 'compass', "~> 0.12.alpha.3"

gem 'heroku_san', :group => :development
gem 'newrelic_rpm'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails', ">= 2.0.1"
end
