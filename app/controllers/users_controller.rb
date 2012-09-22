class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.paginate(:page => params[:page]).order('name ASC')
    @title = "Users"
  end
  
  def show
    @title = @user.name
  end
end
