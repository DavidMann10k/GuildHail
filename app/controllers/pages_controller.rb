class PagesController < ApplicationController
  
  def home
    redirect_to user_path(current_user) if signed_in?
  end

  def about
  end
end
