class AddUserIdToLearnSkill < ActiveRecord::Migration
  def change
    add_column :learn_skills, :user_id, :integer
  end
end
