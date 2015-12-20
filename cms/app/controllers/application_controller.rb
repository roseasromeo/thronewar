class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Helpful authentication methods
  def current_user
    @_current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def admin_user?
    current_user.admin?
  end

  def gm_user?
    current_user.admin? || current_user.gm?
  end

  helper_method :current_user, :admin_user?, :logged_in?
end
