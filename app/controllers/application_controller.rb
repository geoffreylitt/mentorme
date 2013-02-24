# |           ||   ____|   /   \     |   \/   |                                                 
# `---|  |----`|  |__     /  ^  \    |  \  /  |                                                 
#     |  |     |   __|   /  /_\  \   |  |\/|  |                                                 
#     |  |     |  |____ /  _____  \  |  |  |  |                                                 
#     |__|     |_______/__/     \__\ |__|  |__|                                                 
#    _  _    __    __       ___           _______. __    __  .___________.    ___       _______ 
#  _| || |_ |  |  |  |     /   \         /       ||  |  |  | |           |   /   \     /  _____|
# |_  __  _||  |__|  |    /  ^  \       |   (----`|  |__|  | `---|  |----`  /  ^  \   |  |  __  
#  _| || |_ |   __   |   /  /_\  \       \   \    |   __   |     |  |      /  /_\  \  |  | |_ | 
# |_  __  _||  |  |  |  /  _____  \  .----)   |   |  |  |  |     |  |     /  _____  \ |  |__| | 
#   |_||_|  |__|  |__| /__/     \__\ |_______/    |__|  |__|     |__|    /__/     \__\ \______| 
# ____    __    ____  __   ________      ___      .______       _______                         
# \   \  /  \  /   / |  | |       /     /   \     |   _  \     |       \                        
#  \   \/    \/   /  |  | `---/  /     /  ^  \    |  |_)  |    |  .--.  |                       
#   \            /   |  |    /  /     /  /_\  \   |      /     |  |  |  |                       
#    \    /\    /    |  |   /  /----./  _____  \  |  |\  \----.|  '--'  |                       
#     \__/  \__/     |__|  /________/__/     \__\ | _| `._____||_______/                        
                                                                       
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  helper_method :current_user

  around_filter :user_time_zone, :if => :current_user

  private
  
  def user_time_zone(&block)
    Time.use_zone(current_user.timezone, &block)
  end

  #geoffrey's stupid local workaround
=begin
  def authorize
  end

  def current_user
    User.find(1)
  end
=end

  def authorize
    unless current_user
      redirect_to root_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
