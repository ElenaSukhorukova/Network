class InvitesController < ApplicationController
  before_action :authenticate_user!

  def update
    @invite = Invite.find(params[:id])
    if @invite.update(invite_params)
      redirect_to account_friendships_path(current_user.account),
      success: I18n.t('flash.cancel', model: i18n_model_name(@invite).downcase)
    end
  end

  private
    
    def invite_params
      params.require(:invite).permit(:confirmed)
    end
end