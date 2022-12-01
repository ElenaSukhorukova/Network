class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account
  helper_method :find_friend
  after_action :delete_canceled_invites, only: %i[invites]

  include FriendshipsHelper

  def index
    @friends = Friendship.account_friends(@account.id)
  end

  def invites
    @invites_sender = Invite.find_invites_sender(@account.id)
    @invites_receiver = Invite.find_invites_receiver(@account.id)
    @friends = Friendship.account_friends(@account.id)

    render :index
  end

  def create
    @invite = Invite.find(params[:invite_id])
    @sender_id = @invite.sender_invite_id
    @receiver_id = @invite.receiver_invite_id

    unless check_friendship?(@sender_id, @receiver_id)
      @friendship = @invite.build_friendship(f_partner_friendship_id: @sender_id, s_partner_friendship_id: @receiver_id)

      if @friendship.save
        @invite.update(confirmed: 'yes')
        redirect_to account_path(@receiver_id),
          success: I18n.t('flash.accept', model: i18n_model_name(@friendship).downcase)
      end
    end
  end

  private

    def define_account
      @account = Account.find_by(user_id: current_user.id)
      @accounts = Account.except_current_account(current_user.account).order(user_name: :asc)
    end
    
    def find_friend(friendship)
      account_id = friendship.f_partner_friendship_id == current_user.account.id ? friendship.s_partner_friendship_id :
      friendship.f_partner_friendship_id
      Account.find_by(id: account_id)
    end

    def friendship_params
      params.require(:friendship).permit(:confirmed)
    end

    def delete_canceled_invites
      accounts = Account.where(user_id: current_user.id)
      accounts.try(:each) do |account|
        canceled_infites = Invite.where(sender_invite_id: account.id).where(confirmed: 'canceled')
        canceled_infites.destroy_all
      end
    end
end
