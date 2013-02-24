class User < ActiveRecord::Base
  attr_accessible :bio, :email, :fb_uid, :first_name, :image, :last_name, :location, :timezone, :languages

  has_many :languages
  has_many :learn_skills
  has_many :teach_skills
  has_many :time_slots

  def name
    first_name + ' ' + last_name
  end
  
  def language_list
    list = ""
    self.languages.each_with_index do |l,i|
      if i == 0
        list << l.name
      else
        list << ", #{l.name}"
      end
    end
    list
  end

  def meetings
    meetings = []
    meetings << Meeting.where(:mentor_id => self.id)
    meetings << Meeting.where(:translator_id => self.id)
    meetings << Meeting.where(:mentee_id => self.id).all
    meetings.flatten
  end

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

  def matches
    matches = []    
    scores = {}
    ls = self.learn_skills.map{ |s| s.skill_id }
    l = self.languages.map{ |ls| ls.name}
    users = User.all
    users.reject!{ |u| u.id == self.id }
    users.each do |u|
      ts = u.teach_skills.map{ |s| s.skill_id }
      ul = u.languages.map{ |ls| ls.name }
      skill_intersect = (ts & ls).count
      language_intersect = (l & ul).count
      score = skill_intersect + language_intersect * 5
      scores["#{u.id}"] = score
    end
    scores = scores.sort_by{ |k, v| v}.reverse
    matches = scores.map{ |s| User.find(s.first.to_i)}
  end
end
