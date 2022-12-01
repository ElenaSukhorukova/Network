class Accounts::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_interlocutors

  def new
    @message = Message.new
  end

  def create
    @conversation = Conversation.new_conv(@sender.id, @recipient.id)
    @conversation.save
    @message = @conversation.messages.build(message_params)

    @message.sender_message_id = @sender.id
    @message.recipient_message_id = @recipient.id

    if @message.save
      redirect_to account_path(@recipient),
      success: I18n.t('flash.send', model: i18n_model_name(@message).downcase)
    else
      @conversation.destroy
      redirect_to account_path(@recipient),
      danger: "#{@message.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
    end
  end

  private
  
    def define_interlocutors
      @sender = current_user.account
      @recipient = Account.find(params[:account_id])
    end

    def message_params
      params.require(:message).permit(:body, :read)
    end
end
