class CreateTranslators < ActiveRecord::Migration
  def change
    create_table :translators do |t|
      t.integer :user_id
      t.integer :meeting_id

      t.timestamps
    end
  end
end
