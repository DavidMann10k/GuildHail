class AlliancesController < ApplicationController
  load_and_authorize_resource
  def index
    @title = "Alliances"
    @alliances = @alliances.paginate(:page => params[:page]).order('name ASC')
  end

  def new
    @title = "New Alliance"
  end

  def create
    @alliance.owner = current_user
    @alliance.memberships.build(:user => current_user)
    if @alliance.save
      redirect_to @alliance, :notice => "Successfully created alliance."
    else
      render :action => 'new'
    end
  end

  def show
    @title = @alliance.name
    @users = @alliance.users.paginate(:page => params[:page]).order('name ASC')
  end

  def edit
    @title = "Edit #{@alliance.name}"
  end

  def update
    if @alliance.update_attributes(params[:alliance])
      redirect_to @alliance, :notice  => "Successfully updated alliance."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @alliance.destroy
    redirect_to alliances_url, :notice => "Successfully destroyed alliance."
  end
end
