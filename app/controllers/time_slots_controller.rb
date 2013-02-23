class TimeSlotsController < ApplicationController

  def index
    @user = User.find(params[:id])
    @time_slots = @user.time_slots
    respond_to do |format|
      format.html { :layout => "application" }
    end
  end

  def create
    @user = User.find(params[:id])
    @time_slot = @user.time_slots.create(params[:time_slot])
    redirect_to :action => "index"
  end
end