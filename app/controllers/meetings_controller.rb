class MeetingsController < ApplicationController

  skip_before_filter :authorize, :only => :index

  def index
    meetings = User.find(params[:user_id]).meetings
    response = Array.new

    meetings.each do |meeting|
      meeting_hash = Hash.new
      meeting_hash[:id] = meeting.id
      meeting_hash[:mentor_name] = meeting.mentor.name
      meeting_hash[:mentee_name] = meeting.mentee.name
      if meeting.translator.nil?
        meeting_hash[:translator_name] = ""
      else
        meeting_hash[:translator_name] = meeting.translator.name
      end
      meeting_hash[:unix_timestamp] = meeting.unix_timestamp
      meeting_hash[:opentok_session_id] = meeting.opentok_session_id
      meeting_hash[:opentok_token] = meeting.token_for(User.find(params[:user_id]))

      response << meeting_hash
    end

    render :json => response.to_json
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

    @api_key = KEYS[:open_tok][:key]
    
    @session_id = @meeting.opentok_session_id
    @user_role = @meeting.role(current_user)
    @token = @meeting.token_for(current_user)

    @shared_interests = @meeting.mentor.skill_overlap_with @meeting.mentee

  end

end