class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = @users.paginate(:user => params[:page], :per_page => 30)
  end

  def show
  end
end
