class CreateLanguagesUsers < ActiveRecord::Migration
  def change
    create_table :languages_users do |t|
      t.integer :user_id
      t.integer :language_id

    end
  end
end
