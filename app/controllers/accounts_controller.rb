class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account!, except: %i[index new create]
  before_action :define_user!, only: %i[new create]
  before_action :check_filled_profile, only: %i[show]
  after_action :delete_canceled_invites, only: %i[show]

  def index
    @pagy, @accounts = pagy Account.except_current_account(current_user.account), items: 10
    @accounts = @accounts.decorate
  end

  def show
    @pagy_post, @posts = pagy @account.posts.order(created_at: :desc), items: 4, page_param: :pagy_post
    @posts = @posts.decorate

    @hobbies = @account.hobbies

    @post = Post.new
    @message = Message.new
    @hobby = Hobby.new

    @yours_invite = Invite.find_by(confirmed: 'not', sender_invite: current_user.account, receiver_invite: @account)
  end

  def new 
    @account = @user.build_account
    2.times { @account.hobbies.build }
  end

  def create
    @account = @user.build_account(account_params)
    @account.state = Account::STATES[1]
    
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
    @account.state = Account::STATES[1]

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

  def check_filled_profile
    unless current_user.account.present?
      redirect_to new_user_account_path(current_user), 
      warning: I18n.t('flash.fill_account')
    end
  end

    def define_account!
      @account = Account.find(params[:id]).decorate
    end

    def define_user!
      @user = User.find_by(id: current_user.id)
    end
    
    def account_params
      params.require(:account).permit(:user_name, :gender, :date_birthday, 
                                                  :about_oneself, :country, 
                                                  :visibility, :state, 
                                                  hobby_attributes: [:id, :hobby_name, :_destroy])
    end

    def delete_canceled_invites
      accounts = Account.where(user_id: current_user.id)
      accounts.try(:each) do |account|
        canceled_infites = Invite.where(sender_invite_id: account.id).where(confirmed: 'canceled')
        canceled_infites.destroy_all
      end
    end
end
