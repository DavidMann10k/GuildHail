class MessagesController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :alliance
  load_and_authorize_resource :message, :through => [ :user, :alliance ]
  before_filter :load_messagable
  def index
    redirect_to root_path, :notice => 'Access to this action restricted!' unless @messagable == current_user || current_user.member_of?(@messagable)
    @messages = @messagable.messages if @messagable == current_user
    @messages = @messagable.messages if current_user.member_of?(@messagable)
    @title = "Messages for #{@messagable.name}"
  end

  def show
    @message = Message.find(params[:id])
    redirect_to root_path, :notice => 'Access to this action restricted!' unless @messagable == current_user || current_user.member_of?(@messagable) || @message == current_user
  end

  def new
    @message = Message.new
  end

  def create
    @message = @messagable.messages.build(params[:message])
    @message.user = current_user
    if @message.save
      redirect_to :id => nil
    else
      render :action => 'new'
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      redirect_to @message, :notice  => "Successfully updated message."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_url, :notice => "Successfully destroyed message."
  end
  
  def load_messagable
    resource, id = request.path.split('/')[1, 2]
    @messagable = resource.singularize.classify.constantize.find(id)
  end
end
