class AddUserIdToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :user_id, :integer
  end
end
