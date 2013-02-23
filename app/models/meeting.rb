class Meeting < ActiveRecord::Base
  attr_accessible :opentok_session_id, :time
  before_create :populate_session_id

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
