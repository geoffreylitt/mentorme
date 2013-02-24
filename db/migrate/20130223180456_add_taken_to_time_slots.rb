class AddTakenToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :taken, :boolean, default: false
  end
end
