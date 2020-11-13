class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: Blinkist::Config.get!("basic_auth_username"), password: Blinkist::Config.get!("basic_auth_password")
end
