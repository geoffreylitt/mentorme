class TeachSkill < ActiveRecord::Base
  attr_accessible :skill_id

  belongs_to :user
end
