class Accounts::InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_accounts

  def create
    @invite = Invite.new(sender_invite_id: @sender.id, receiver_invite_id: @receiver.id)

    if @invite.save
      redirect_to account_path(@receiver),
        success: I18n.t('flash.send', model: i18n_model_name(@invite).downcase)
    end
  end

  def update
    @invite = Invite.find(params[:id])
    @account = Account.find(params[:account_id])
    if @invite.update(invite_params)
      redirect_to account_path(@account),
      success: I18n.t('flash.cancel', model: i18n_model_name(@invite).downcase)
    end
  end

  private

  def define_accounts
    @sender = Account.find_by(user_id: current_user.id)
    @receiver = Account.find(params[:account_id])
  end

  def invite_params
    params.require(:invite).permit(:confirmed)
  end
end
