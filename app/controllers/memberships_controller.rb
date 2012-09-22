class MembershipsController < ApplicationController
  load_and_authorize_resource
  def index
    @memberships = current_user.memberships
    @title = "Memberships"
  end
  
  def show
    @title = "#{@membership.alliance.name} Membership"
  end

  def create
    @invitation = Invitation.find(params[:invitation_id])
    return redirect_to root_path, :notice => 'Access to this action restricted!' unless current_user == @invitation.recipient
    @membership.user = @invitation.recipient
    @membership.alliance = @invitation.alliance
    
    if @membership.save
      redirect_to @membership, :notice => "You have accepted an invitation to join #{@membership.alliance.name}"
      @invitation.destroy
    else
      render :action => 'new'
    end
  end

  def destroy
    name = @membership.alliance
    @membership.destroy
    redirect_to invitations_url, :notice => "You have left #{name}."
  end
end
