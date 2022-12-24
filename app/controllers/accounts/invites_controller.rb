# frozen_string_literal: true

class Accounts::InvitesController < ApplicationController
  include InvitesHelper
  before_action :authenticate_user!
  before_action :define_accounts!

  def create
    return if check_invite?(@sender.id, @receiver.id)

    @invite = Invite.new sender_invite_id: @sender.id, receiver_invite_id: @receiver.id

    return unless @invite.save

    redirect_to account_path(@receiver),
                success: I18n.t('flash.send', model: i18n_model_name(@invite).downcase)
  end

  def update
    @invite = Invite.find params[:id]
    @account = Account.find params[:account_id]
    return unless @invite.update invite_params

    redirect_to account_path(@account),
                success: I18n.t('flash.cancel', model: i18n_model_name(@invite).downcase)
  end

  private

  def define_accounts!
    @sender = current_user.account
    @receiver = Account.find params[:account_id]
  end

  def invite_params
    params.require(:invite).permit(:confirmed)
  end
end
