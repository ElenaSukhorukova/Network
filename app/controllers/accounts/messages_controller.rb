# frozen_string_literal: true

class Accounts::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_interlocutors!

  def new
    @message = Message.new
  end

  def create
    build_message
    path = account_path(@recipient)

    return redirect_to path, success: I18n.t('flash.send', model: i18n_model_name(@message).downcase) if @message.save

    @conversation.destroy
    redirect_to path, danger: @message.errors.full_messages.each(&:capitalize).join(' ').to_s
  end

  private

  def create_conversation
    @conversation = Conversation.new_conv @sender, @recipient
    @conversation.save if @conversation.new_record?
  end

  def define_interlocutors!
    @sender = current_user.account
    @recipient = Account.find params[:account_id]
  end

  def build_message
    create_conversation
    @message = @conversation.messages.build message_params

    @message.sender_message = @sender
    @message.recipient_message = @recipient
  end

  def message_params
    params.require(:message).permit(:body, :read)
  end
end
