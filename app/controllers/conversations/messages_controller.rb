class Conversations::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_interlocutors, only: %i[ create ]
  before_action :define_message, only: %i[edit update destroy]
  include FindInterlocutorHelper
  
  def create
    @message = @conversation.messages.build(message_params)

    @message.sender_message_id = @sender.id
    @message.recipient_message_id = @recipient.id

    if @message.save
      redirect_to account_conversation_path(current_user.account, @conversation), 
      success: I18n.t('flash.send', model: i18n_model_name(@message).downcase)
    else
      redirect_to account_conversation_path(current_user.account, @conversation),
        danger: "#{@message.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
    end
  end

  def edit
  end

  def update
    @message = Message.find(params[:id])

    if current_user.account.id == @message.sender_message_id
      if @message.update(message_params)
        redirect_to account_conversation_path(current_user.account, @message.conversation),
        success: I18n.t('flash.update', model: i18n_model_name(@message).downcase)
      else
        redirect_to account_conversation_path(current_user.account,  @message.conversation),
        danger: "#{@message.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @conversation = @message.conversation

    if current_user.account.id == @message.sender_message_id
      if @message.destroy
        # delete conversation if it hasn't messages
        if @conversation.messages.empty?
          @conversation.destroy
          redirect_to account_conversations_path(current_user.account), 
          success: I18n.t('flash.destroy', model: i18n_model_name(@conversation).downcase)
        else
          redirect_to account_conversation_path(current_user.account, @message.conversation), 
          success: I18n.t('flash.destroy', model: i18n_model_name(@message).downcase)
        end
      end
    end
  end

  private
    
    def define_interlocutors
      @conversation = Conversation.find(params[:conversation_id])
      @sender = current_user.account
      @recipient = find_interlocutor(@sender.id, @conversation)
    end

    def define_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:body, :read)
    end
end
