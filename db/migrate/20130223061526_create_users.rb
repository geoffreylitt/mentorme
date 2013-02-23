class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fb_uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image
      t.string :location
      t.int :timezone
      t.string :bio

      t.timestamps
    end
  end
end
