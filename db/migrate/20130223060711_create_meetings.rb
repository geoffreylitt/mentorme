class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :time
      t.string :opentok_session_id

      t.timestamps
    end
  end
end
