class Accounts::HobbiesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account!

  def new
    @hobby = Hobby.new
  end

  def create
    @hobby = Hobby.new_hobby hobby_params
    if @hobby.save
      @account.hobbies << @hobby unless @account.hobbies.find_by(hobby_name: @hobby.hobby_name)
      
      redirect_to account_path(@account),
        success: I18n.t('flash.new', model: i18n_model_name(@hobby).downcase)
    else
      redirect_to account_path(@account),
      danger: "#{@hobby.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
    end
  end

  private

  def define_account!
    @account = Account.find_by user_id: current_user.id
  end

  def hobby_params
    params.require(:hobby).permit(:hobby_name)
  end
end