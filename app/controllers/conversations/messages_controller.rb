# frozen_string_literal: true

class Conversations::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_interlocutors!, only: %i[create]
  before_action :define_message!, only: %i[edit update destroy]
  include ConversationsHelper

  def edit; end

  def create
    build_message
    path = conversation_path(@conversation)

    return redirect_to path, success: I18n.t('flash.send', model: i18n_model_name(@message).downcase) if @message.save

    edirect_to path, danger: @message.errors.full_messages.each(&:capitalize).join(' ').to_s
  end

  def update
    return unless @account.id == @message.sender_message_id

    path = conversation_path(@message.conversation)
    if @message.update message_params
      return redirect_to path,
                         success: I18n.t('flash.update',
                                         model: i18n_model_name(@message).downcase)
    end

    redirect_to path, danger: @message.errors.full_messages.each(&:capitalize).join(' ').to_s
  end

  def destroy
    @conversation = @message.conversation

    return unless @account.id == @message.sender_message_id && @message.destroy

    # delete conversation if it hasn't messages
    destroy_conversation

    redirect_to conversation_path(@message.conversation),
                success: I18n.t('flash.destroy', model: i18n_model_name(@message).downcase)
  end

  private

  def define_interlocutors!
    @conversation = Conversation.find params[:conversation_id]
    @sender = current_user.account
    @recipient = find_interlocutor @conversation
  end

  def define_message!
    @message = Message.find params[:id]
    @account = current_user.account
  end

  def build_message
    @message = @conversation.messages.build message_params

    @message.sender_message = @sender
    @message.recipient_message = @recipient
  end

  def destroy_conversation
    return unless @conversation.messages.empty?

    @conversation.destroy
    redirect_to account_conversations_path(@account),
                success: I18n.t('flash.destroy', model: i18n_model_name(@conversation).downcase)
  end

  def message_params
    params.require(:message).permit(:body, :read)
  end
end
