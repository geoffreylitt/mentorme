class Mentor < ActiveRecord::Base
  attr_accessible :meeting_id, :user_id

  belongs_to :meeting
end
