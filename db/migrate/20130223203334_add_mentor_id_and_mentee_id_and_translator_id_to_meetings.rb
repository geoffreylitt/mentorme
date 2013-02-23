class AddMentorIdAndMenteeIdAndTranslatorIdToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :mentor_id, :integer
    add_column :meetings, :mentee_id, :integer
    add_column :meetings, :translator_id, :integer
  end
end
