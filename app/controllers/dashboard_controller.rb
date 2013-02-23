class DashboardController < ApplicationController
  def index
    @user = current_user
    @matches = current_user.matches
    @translate_meetings = Meeting.where(:translator_id => nil)

    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end
end