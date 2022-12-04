class Accounts::ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account!
  include FindInterlocutorHelper

  def index
    @conversations = Conversation.account_conversations(@account.id)
  end

  def show
    @conversations = Conversation.account_conversations(@account.id)
    @conversation = Conversation.find(params[:id])

    @messages = @conversation.messages.order(created_at: :asc)
    @message = @conversation.messages.build

    @sender = @account
    @recipient = find_interlocutor(@sender.id, @conversation)
    render 'index'
  end

  private

  def define_account!
    @account = Account.find_by(user_id: current_user.id)
  end
end
