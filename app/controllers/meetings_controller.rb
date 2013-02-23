class MeetingsController < ApplicationController
   def show
    @meeting = Meeting.find(params[:id])

    api_key = KEYS[:open_tok][:key]
    api_secret = KEYS[:open_tok][:secret]

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret 
    @api_key = api_key #expose api_key

    @session = @meeting.opentok_session_id
    #@session = "2_MX4yMzAyNzExMn4xMjcuMC4wLjF-RnJpIEZlYiAyMiAxMzo1MDozMiBQU1QgMjAxM34wLjI0MTE3NzU2fg"

    @token = opentok.generate_token :session_id => @session
  end
end