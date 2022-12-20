class Accounts::ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account!
  include ConversationsHelper

  def index
    @pagy, @conversations = pagy Conversation.account_conversations(@account), items: 11
  end

  def show
    @pagy, @conversations = pagy Conversation.account_conversations(@account), items: 11
    @conversation = Conversation.find params[:id]

    @messages = @conversation.messages.order(:created_at)
    @messages = @messages.decorate
    @message = @conversation.messages.build

    @recipient = find_interlocutor(@conversation).decorate
    @sender = @account.decorate
    render 'index'
  end

  private

  def define_account!
    @account = Account.find params[:account_id]
  end
end
