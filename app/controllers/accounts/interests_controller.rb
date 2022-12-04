class Accounts::InterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account!

  def new
    @interest = Interest.new
  end

  def create
    @interest = @account.interests.build(interest_params)
    if @interest.save
      redirect_to account_path(@account),
        success: I18n.t('flash.new', model: i18n_model_name(@interest).downcase)
    else
      redirect_to account_path(@account),
      danger: "#{@message.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
    end
  end

  private

    def define_account!
      @account = Account.find_by(user_id: current_user.id)
    end

    def interest_params
      params.require(:interest).permit(:name_interest)
    end
end