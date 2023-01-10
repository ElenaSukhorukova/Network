# frozen_string_literal: true

module Accounts
  class FriendshipsController < ApplicationController
    include DeleteInvite
    before_action :authenticate_user!
    after_action :delete_invite

    def destroy
      @account = current_user.account
      @account = @account.decorate
      @friendship = Friendship.find params[:id]

      return unless @friendship.destroy

      @friendship.invite.destroy
      redirect_to account_path(@account),
                  success: I18n.t('flash.friend_canceled', username: @account.capitalize_name)
    end
  end
end
