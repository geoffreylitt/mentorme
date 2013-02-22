class VideoSessionController < ApplicationController
  def show
    api_key = KEYS[:open_tok][:key]        # Replace with your OpenTok API key.
    api_secret = KEYS[:open_tok][:secret]  # Replace with your OpenTok API secret.

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret 
    session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "disabled"}
    @api_key = api_key #expose api_key
    @session = opentok.create_session request.remote_addr, session_properties
    @token = opentok.generate_token :session_id => @session

  end
end