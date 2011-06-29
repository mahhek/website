require 'utility'
require 'google'
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  alias :logged_in? :user_signed_in?
  alias :login_required :authenticate_user!
  helper_method :current_user_session, :current_user
  private
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
