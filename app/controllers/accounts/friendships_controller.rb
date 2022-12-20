class Accounts::FriendshipsController < ApplicationController
  include DeleteInvite
  before_action :authenticate_user!
  after_action :delete_invite


  def destroy
    @account = Account.find params[:account_id]
    @account = @account.decorate
    @friendship = Friendship.find params[:id]

    if @friendship.destroy
      @friendship.invite.destroy
      redirect_to account_path(@account),
        success: I18n.t('flash.friend_canceled', username: @account.capitalize_name)
    end
  end
end