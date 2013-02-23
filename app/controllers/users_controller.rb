class UsersController < ApplicationController
  def index
    @user = current_user
    @matches = current_user.matches
    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end

  def show
    @user = User.find(params[:id])
    @params = params
    @time_slots = @user.time_slots.sort_by{|ts| ts.time}

    @new_time_slot = TimeSlot.new
    @meeting = Meeting.new

    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end

  def edit
  	@user = User.find(params[:id])
    @skills = Skill.all
  	respond_to do |format|
  		format.html { render :layout => "application"}
  	end
  end

	def update

    @user = User.find(params[:id])
    @user.languages = []
    if params[:languages]
      params[:languages].each do |language|
        @user.languages << Language.create(:name => language)
      end
      params[:languages] = nil
    end
    if params[:learn_skills]
      @user.learn_skills.each do |ls|
        ls.delete
      end
      params[:learn_skills].each do |skill_id|
        @user.learn_skills << LearnSkill.create(:skill_id => skill_id)
      end
      params[:learn_skills] = nil
    end
    if params[:teach_skills]
      @user.teach_skills.each do |ts|
          ts.delete
      end
      params[:teach_skills].each do |skill_id|  
        @user.teach_skills << TeachSkill.create(:skill_id => skill_id)
      end
      params[:teach_skills] = nil
    end

    if params[:bio]
      params[:user] = true
      params[:user] = {:bio => params[:bio]}
      params[:bio] = nil
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
      	format.html { redirect_to action: "show" }
      else
        render 'edit'
      end
    end
  end
end