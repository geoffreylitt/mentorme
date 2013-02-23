class DropMentorsAndMenteesAndTranslators < ActiveRecord::Migration
  def up
    drop_table :mentors
    drop_table :mentees
    drop_table :translators
  end

  def down
    create_table :mentors do |t|
      t.integer :user_id
      t.integer :meeting_id

      t.timestamps
    end

    create_table :mentees do |t|
      t.integer :user_id
      t.integer :meeting_id

      t.timestamps
    end

    create_table :translators do |t|
      t.integer :user_id
      t.integer :meeting_id

      t.timestamps
    end
  end
end
