class Meeting < ActiveRecord::Base
  attr_accessible :opentok_session_id, :time, :mentor_id, :mentee_id, :translator_id
  before_create :populate_session_id

  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"
  belongs_to :translator, :class_name => "User"

  def role(user)
    if self.mentor == user
      role_str = "mentor"
    elsif self.mentee == user
      role_str = "mentee"
    elsif self.translator == user
      role_str = "translator"
    else
      role_str = ""
    end

    role_str
  end

  def mentor_name
    self.mentor.name
  end

  def mentee_name
    self.mentee.name
  end

  def translator_name
    self.translator.name
  end

  protected

  def populate_session_id
    api_key = KEYS[:open_tok][:key]
    api_secret = KEYS[:open_tok][:secret]

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret 
    session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "disabled"}

    opentok_session = opentok.create_session session_properties
    self.opentok_session_id = opentok_session.session_id
  end
end
