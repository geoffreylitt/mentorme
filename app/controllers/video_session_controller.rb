class VideoSessionController < ApplicationController
  def show
    api_key = KEYS[:open_tok][:key]        # Replace with your OpenTok API key.
    api_secret = KEYS[:open_tok][:secret]  # Replace with your OpenTok API secret.

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret 
    session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "disabled"}
    @api_key = api_key #expose api_key

    # eventually, the flow should be:
    # test if we have a opentok session ID for this videochat in the db already.
    # if yes, use that. if not, generate one using the below code and store it.
    # for now, we will hardcode the session ID to allow multi user chat

    #@session = opentok.create_session request.remote_addr, session_properties

    @session = "2_MX4yMzAyNzExMn4xMjcuMC4wLjF-RnJpIEZlYiAyMiAxMzo1MDozMiBQU1QgMjAxM34wLjI0MTE3NzU2fg"
    
    @token = opentok.generate_token :session_id => @session

  end
end