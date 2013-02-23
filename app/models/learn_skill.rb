class LearnSkill < ActiveRecord::Base
  attr_accessible :skill_id, :user_id

  belongs_to :user
end
