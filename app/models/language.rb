class Language < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_and_belongs_to_many :users
end
