class UsersController < ApplicationController
  load_and_authorize_resource
  def index
    @users = User.paginate(:page => params[:page]).order('name ASC')
  end
  
  def show
  end
end
