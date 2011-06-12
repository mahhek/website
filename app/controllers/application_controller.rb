class ApplicationController < ActionController::Base
  require 'lib/util'
  require 'lib/google'
  protect_from_forgery
end
