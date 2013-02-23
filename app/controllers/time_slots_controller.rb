class TimeSlotsController < ApplicationController

  def index
    @user = current_user
    @time_slots = @user.time_slots
    respond_to do |format|
      format.html { render :layout => "application" }
    end
  end

  def create
    @user = current_user
    @time_slot = @user.time_slots.create(params[:time_slot])
    redirect_to :action => "index"
  end

  def new
    @time_slot = TimeSlot.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @time_slot }
    end
  end
end