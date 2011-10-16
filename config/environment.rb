# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BlogMahLabCom::Application.initialize!

# for multibyte
Encoding.default_external = 'UTF-8'

