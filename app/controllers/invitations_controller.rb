class InvitationsController < ApplicationController
  def index
    @invitations = Invitation.all
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      redirect_to @invitation, :notice => "Successfully created invitation."
    else
      render :action => 'new'
    end
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to invitations_url, :notice => "Successfully destroyed invitation."
  end
end
