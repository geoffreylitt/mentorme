class IosController < ApplicationController
  def auth_from_fb_uid
    u = User.find_by_fb_uid(params[:fb_id])
    @response = Hash.new
    if u.nil?
      @response = {:authorized => false}
    else
      @response = {:authorized => true, :user_id => u.id}
    end

    respond_to do |format|
      format.json {render :json => @response}
    end
  end
end