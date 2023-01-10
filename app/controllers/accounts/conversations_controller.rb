# frozen_string_literal: true

module Accounts
  class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :define_account!
    include ConversationsHelper

    def index
      @conversations = Conversation.account_conversations(@account).order(updated_at: :desc)
    end

    def show
      @conversations = Conversation.account_conversations(@account).order(updated_at: :desc)
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
      @account = current_user.account
    end
  end
end
