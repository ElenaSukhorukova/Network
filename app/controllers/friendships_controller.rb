class FriendshipsController < ApplicationController
  include InvitesHelper
  include FriendshipsHelper
  include DeleteInvite
  before_action :authenticate_user!
  before_action :define_account!
  before_action :delete_canceled_invites, only: %i[index]
  after_action :delete_invite, only: %i[destroy]

  def index
    @pagy_friend, @friends = pagy Friendship.user_friends(@sender), items: 10, page_param: :pagy_friend
    
    @pagy_invites_sender, @invites_sender = pagy Invite.account_sender_invites(@sender), items: 7, page_param: :pagy_invites_sender
    @pagy_invites_receiver, @invites_receiver = pagy Invite.account_receiver_invites(@sender), items: 7, page_param: :pagy_invites_receiver
  end

  def create
    @invite = Invite.find params[:invite_id]
    @sender = @invite.sender_invite
    @receiver = @invite.receiver_invite

    unless check_friendship? @sender, @receiver
      @friendship = @invite.build_friendship(f_partner_friendship: @sender, s_partner_friendship: @receiver)

      if @friendship.save
        @invite.update confirmed: 'yes'
        redirect_to account_friendships_path(@sender),
          success: I18n.t('flash.accept', model: i18n_model_name(@friendship).downcase)
      end
    end
  end

  def destroy
    @friendship = Friendship.find params[:id]

    if @friendship.destroy
      @friendship.invite.destroy
      redirect_to account_friendships_path(@sender),
        success: I18n.t('flash.friend_canceled', username: find_friend(@friendship).capitalize_name)
    end
  end
  
  private

  def define_account!
    @sender = Account.find_by user_id: current_user.id
    @pagy_account, @accounts = pagy Account.except_current_account(@sender).order(user_name: :asc), items: 20, page_param: :pagy_account
    @accounts = @accounts.decorate
  end

  def delete_canceled_invites
    canceled_infites = Invite.where(confirmed: 'canceled')
    canceled_infites.destroy_all
  end
    
  def friendship_params
    params.require(:friendship).permit(:confirmed)
  end
end
