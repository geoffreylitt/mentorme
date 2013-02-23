class UsersController < ApplicationController
  def show
    @user = current_user
    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end

  def edit
  	@user = current_user
  	respond_to do |format|
  		format.html { render :layout => "application"}
  	end
  end

	def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
      	redirect_to profile_url
      else
        render 'edit'
      end
    end
  end
end