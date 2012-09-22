class PagesController < ApplicationController
  
  def home
    redirect_to user_path(current_user) if signed_in?
    @title = "Home"
  end

  def about
    @title = "About"
  end
end
