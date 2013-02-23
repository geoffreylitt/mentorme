class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  helper_method :current_user

  private

  def authorize
    #unless current_user
    #  redirect_to root_url
    #end
  end

  def current_user
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user = User.find(1)
  end
end
