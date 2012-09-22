class InvitationsController < ApplicationController
  load_and_authorize_resource
  def index
    @title = "Invitations"
    @invitations_sent = Invitation.sent_by(current_user)
    @invitations_recieved = Invitation.recieved_by(current_user)
  end

  def new
    @title = "New Invitation"
  end

  def create
    @invitation.alliance = Alliance.find params[:alliance_id]
    redirect_to root_path, :notice => 'Access to this action restricted!' unless current_user.owns? @invitation.alliance
    @invitation.sender = current_user
    @invitation.recipient = User.find params[:user_id]
    
    if @invitation.save
      redirect_to @invitation, :notice => "Successfully created invitation."
    else
      render :action => 'new'
    end
  end

  def show
    @title = "Invitation to Join #{@invitaion.alliance}"
    redirect_to root_path, :notice => 'Access to this action restricted!' unless @invitation.sender == current_user || @invitation.recipient == current_user
  end

  def destroy
    @invitation.destroy
    redirect_to invitations_url, :notice => "Successfully destroyed invitation."
  end
end
