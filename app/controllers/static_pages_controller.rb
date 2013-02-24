class StaticPagesController < ApplicationController
  skip_filter :authorize

  def home
    respond_to do |format|
      format.html {render :layout => "landing"}
    end
  end

end