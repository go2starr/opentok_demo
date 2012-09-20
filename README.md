# Opentok Demo  
This is a basic app to enable video chatting with multiple users at
the same time using the opentok api.

## Setup 

Simply add a file, e.g. `secret_token.rb' to your config/initializers
and set values for:
* OpentokDemo::Application.config.secret_token 
* OpentokDemo::Application.config.api_key

bundle install, rake db:migrate, etc. and you are good to go!
