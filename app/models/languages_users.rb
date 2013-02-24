class LanguagesUsers < ActiveRecord::Base

  belongs_to :user
  belongs_to :language
  
  attr_accessible :language_id, :user_id
end
