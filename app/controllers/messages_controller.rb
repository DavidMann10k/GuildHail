class MessagesController < ApplicationController
  authorize_resource :user
  authorize_resource :alliance
  authorize_resource :message, :through => [ :user, :alliance ]
  before_filter :load_messagable
  
  def index
    @messages = []
    @sent_messages = []
    @alliance = @messagable if @messagable.class == Alliance
    @user = @messagable if @messagable.class == User
    @authorized = @messagable == current_user || current_user.member_of?(@messagable)
    @messages = @messagable.messages if @messagable == current_user
    @messages = @messagable.messages if current_user.member_of?(@messagable)
    @sent_messages = @messagable.sent_messages if @messagable == current_user
    @title = "Messages for #{@messagable.name}"
  end

  #def show
  #  @message = Message.find(params[:id])
  #  redirect_to root_path, :notice => 'Access to this action restricted!' unless @messagable == current_user || current_user.member_of?(@messagable) || @message == current_user
  #end

  def new
    @message = Message.new
  end

#can create a message if
  #recipient is another user
  #recipient is an alliance he is a memeber of
  def create
    @message = @messagable.messages.build(params[:message])
    return redirect_to :back if @messagable.class == Alliance && !user.member_of?(@messagable)
    @message.user = current_user
    if @message.save
      redirect_to polymorphic_path([@messagable, :messages])
    else
      render :action => 'new'
    end
  end

  #def edit
  #  @message = Message.find(params[:id])
  #end

  #def update
  #  @message = Message.find(params[:id])
  #  if @message.update_attributes(params[:message])
  #    redirect_to @message, :notice  => "Successfully updated message."
  #  else
  #    render :action => 'edit'
  #  end
  #end

#can destroy if 
  #user is the author of the message
  #user is the owner of the alliance to which the messages was sent
  def destroy
    return redirect_to :back unless @message.user == current_user || current_user.owns?(@messagable)
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to :back
  end
  
  def load_messagable
    resource, id = request.path.split('/')[1, 2]
    @messagable = resource.singularize.classify.constantize.find(id)
  end
end
