class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account, except: %i[index new create]
  before_action :define_user, only: %i[new create]

  def index
    @accounts = Account.all.where.not(user_id: current_user.id).order(user_name: :asc)
  end

  def show
  end

  def new 
    @account = @user.build_account
  end

  def create
    @account = @user.build_account(account_params)
    @account.state = Account::STATE[1]
    
    if @account.save     
      redirect_to account_path(@account), 
        success: I18n.t('flash.new', model: i18n_model_name(@account).downcase)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @account.state = Account::STATE[1]
    if @account.update(account_params)
      redirect_to account_path(@account),
        success: I18n.t('flash.update', model: i18n_model_name(@account).downcase)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @account.destroy
      redirect_to root_path, 
        success: I18n.t('flash.destroy', model: i18n_model_name(@account).downcase)
    end
  end

  private

    def define_account
      @account = Account.find(params[:id])
    end

    def define_user
      @user = User.find_by(id: current_user.id)
    end

    def account_params
      params.require(:account).permit(:user_name, :gender, :date_birthday, :about_oneself, :country, :visibility, :state)
    end
end