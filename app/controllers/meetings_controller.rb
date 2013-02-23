class MeetingsController < ApplicationController

  def index
    @meetings = User.find(params[:user_id]).meetings

    render :json => @meetings.to_json(:methods => [:mentor_name, :mentee_name, :translator_name])
  end

  def create
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
    @names = {:mentor => @meeting.mentor_name, :mentee => @meeting.mentee_name, :translator => @meeting.translator_name}

    #enable this and make a helper method once we have users
    #@user_role = current_user.role_in_meeting(@meeting)

    #todo: populate names for real

    @token = opentok.generate_token :session_id => @session, :connection_data => @user_role

  end

end