class AddTakenToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :taken, :boolean
  end
end
