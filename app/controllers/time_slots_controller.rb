class TimeSlotsController < ApplicationController

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