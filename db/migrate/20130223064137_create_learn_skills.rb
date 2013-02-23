class CreateLearnSkills < ActiveRecord::Migration
  def change
    create_table :learn_skills do |t|
      t.integer :skill_id

      t.timestamps
    end
  end
end
