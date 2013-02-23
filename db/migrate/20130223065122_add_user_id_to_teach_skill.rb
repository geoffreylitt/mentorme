class AddUserIdToTeachSkill < ActiveRecord::Migration
  def change
    add_column :teach_skills, :user_id, :integer
  end
end
