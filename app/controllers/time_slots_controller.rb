class TimeSlotsController < ApplicationController

  def index
    @user = current_user
    @time_slots = @user.time_slots.sort_by{|ts| ts.time}
    @new_time_slot = TimeSlot.new

    @meeting = Meeting.new #new meeting to populate if they apply to a slot

    respond_to do |format|
      format.html {render :layout => "application" }
    end
  end

  def create
    @user = current_user
    @time_slot = @user.time_slots.create(params[:time_slot])
    redirect_to :action => "index"
  end

  def destroy
    @time_slot = TimeSlot.find(params[:id])
    @time_slot.destroy

    redirect_to user_time_slots_url(current_user)
  end

end