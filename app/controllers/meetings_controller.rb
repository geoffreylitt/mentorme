class MeetingsController < ApplicationController

  skip_before_filter :authorize, :only => :index

  def index
    @meetings = User.find(params[:user_id]).meetings

    render :json => @meetings.to_json(:methods => [:mentor_name, :mentee_name, :translator_name, :unix_timestamp])
  end

  def create
    ts = TimeSlot.find(params[:meeting][:time_slot_id])
    ts.taken = true
    ts.save
    params[:meeting].delete(:time_slot_id)
    @meeting = Meeting.new(params[:meeting])
    if @meeting.save
      redirect_to root_url, :notice => 'Meeting successfully scheduled at ' + @meeting.time.strftime("%a, %B %d -- %H:%M")
    else
      render action: "new"
    end
  end

  def update
    @meeting = Meeting.find(params[:id])

    if @meeting.update_attributes(params[:meeting])
      redirect_to root_url, :notice => 'Successfully applied to translate meeting'
    else
      redirect_to root_url, :error => 'Sorry, something went wrong. Please try again.'
    end
  end 

  def show
    @meeting = Meeting.find(params[:id])

    api_key = KEYS[:open_tok][:key]
    api_secret = KEYS[:open_tok][:secret]

    opentok = OpenTok::OpenTokSDK.new api_key, api_secret 

    @api_key = api_key #expose api_key
    @session_id = @meeting.opentok_session_id

    @user_role = @meeting.role(current_user) 

    @token = opentok.generate_token :session_id => @session, :connection_data => @user_role

    @shared_interests = @meeting.mentor.skill_overlap_with @meeting.mentee

  end

end