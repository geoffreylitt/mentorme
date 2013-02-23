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
      	format.html { redirect_to action: "show" }
      else
        render 'edit'
      end
    end
  end
end