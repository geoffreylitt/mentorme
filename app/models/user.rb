class User < ActiveRecord::Base
  attr_accessible :bio, :email, :fb_uid, :first_name, :image, :last_name, :location, :timezone

  has_many :languages
  has_many :learn_skills
  has_many :teach_skills
  has_many :time_slots

  def self.from_omniauth(auth)
    User.find_by_fb_uid(auth["uid"]) || create_from_omniauth(auth)
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.fb_uid = auth["uid"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
      user.location = auth["info"]["location"]
      user.timezone = auth["extra"]["raw_info"]["timezone"]
    end
  end

end
