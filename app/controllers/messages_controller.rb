class MessagesController < ApplicationController
  authorize_resource :user
  authorize_resource :alliance
  authorize_resource :message, :through => [ :user, :alliance ]
  before_filter :load_messagable
  def index
    @messages = []
    @unauthorized = @messagable != current_user || !current_user.member_of?(@messagable)
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
      redirect_to polymorphic_path([@messagable, :messages])
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
    redirect_to :back
  end
  
  def load_messagable
    resource, id = request.path.split('/')[1, 2]
    @messagable = resource.singularize.classify.constantize.find(id)
  end
end
