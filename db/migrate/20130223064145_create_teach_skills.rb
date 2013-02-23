class CreateTeachSkills < ActiveRecord::Migration
  def change
    create_table :teach_skills do |t|
      t.integer :skill_id

      t.timestamps
    end
  end
end
