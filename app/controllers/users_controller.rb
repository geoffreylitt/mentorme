class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html {render :layout => "application"}
    end
  end

  def edit
  	@user = User.find(params[:id])
  	respond_to do |format|
  		format.html { render :layout => "application"}
  	end
  end

	def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
      	format.html { redirect_to action: "show" }
      else
        render 'edit'
      end
    end
  end
end