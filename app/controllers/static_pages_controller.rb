class StaticPagesController < ApplicationController
  skip_filter :authorize

  def home

  end

end
