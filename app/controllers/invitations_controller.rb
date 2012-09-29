class InvitationsController < ApplicationController
  load_and_authorize_resource
  def index
    @title = "Invitations"
    @invitations_sent = Invitation.sent_by(current_user)
    @invitations_recieved = Invitation.recieved_by(current_user)
  end

  def new
    @title = "Invite #{User.find(params[:user_id]).name} to #{Alliance.find(params[:alliance_id]).name} "
  end

  def create
    @invitation.alliance = Alliance.find params[:alliance_id]
    return redirect_to root_path, :notice => 'Access to this action restricted!' unless current_user.owns? @invitation.alliance
    @invitation.sender = current_user
    @invitation.recipient = User.find params[:user_id]
    return redirect_to :back, :notice => "Invitation to #{@invitation.alliance.name} for #{@invitation.recipient.name} already exists!" if Invitation.exists_for?(@invitation.recipient, @invitation.alliance)
    if @invitation.save
      redirect_to @invitation, :notice => "Successfully created invitation."
    else
      render :action => 'new'
    end
  end

  def show
    @title = "Invitation to Join #{@invitation.alliance.name}"
    redirect_to root_path, :notice => 'Access to this action restricted!' unless @invitation.sender == current_user || @invitation.recipient == current_user
  end

  def destroy
    @invitation.destroy
    redirect_to invitations_url, :notice => "Successfully destroyed invitation."
  end
end
