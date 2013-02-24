class AddTitanpadIdToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :titanpad_id, :string
  end
end
