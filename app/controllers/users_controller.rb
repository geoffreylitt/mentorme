class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end

  def show
    @user = User.find(params[:id])
    @params = params
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

    if params[:languages]
      params[:languages].each do |language_id|
        @user.languages << Language.find(language_id)
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
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
      	format.html { redirect_to action: "show" }
      else
        render 'edit'
      end
    end
  end
end