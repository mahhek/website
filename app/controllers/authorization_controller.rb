class AuthorizationController < ApplicationController
  check_authorization
  load_and_authorize_resource


  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "You don't have the permission to access this page"
    redirect_to root_url
  end
end
