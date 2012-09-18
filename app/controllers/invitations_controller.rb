class InvitationsController < ApplicationController
  load_and_authorize_resource
  def index
    @invitations_sent = Invitation.sent_by(current_user)
    @invitations_recieved = Invitation.recieved_by(current_user)
  end

  def new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    
    if @invitation.save
      redirect_to @invitation, :notice => "Successfully created invitation."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to invitations_url, :notice => "Successfully destroyed invitation."
  end
end
