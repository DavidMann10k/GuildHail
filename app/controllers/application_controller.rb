class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_timezone
  
  helper :layout
  
  def set_timezone
    Time.zone = time_zone
    
  end
  
  def time_zone
    if (signed_in?)
      current_user.time_zone
    else
      ActiveSupport::TimeZone.new("Central Time (US and Canada)")
    end
  end
end