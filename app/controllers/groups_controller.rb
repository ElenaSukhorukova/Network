# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account!, except: %i[edit update destroy]
  before_action :define_group!, except: %i[index new create]

  def index
    @pagy, @all_groups = pagy Group.order(:name_group), items: 5
    @all_groups = @all_groups.decorate
  end

  def your_groups
    @pagy, @created_groups = pagy Group.where(group_creator: @account).order(:name_group), items: 5
    @created_groups = @created_groups.decorate
  end

  def participation_groups
    # @pagy, @participation_groups = pagy @account.groups.where.not(group_creator_id: @account.id), items: 5
    # @participation_groups = @participation_groups.decorate
  end

  def show
    @hobby = Hobby.new
    @pagy, @contents = pagy @group.contents.order(created_at: :desc), items: 5
    @contents = @contents.decorate
    @participants = @group.accounts
  end

  def new
    @group = @account.groups.build
    3.times { @group.hobbies.build }
  end

  def edit; end

  def create
    @group = @account.groups.build group_params
    if @group.save
      redirect_to group_path(@group),
                  success: I18n.t('flash.new', model: i18n_model_name(@group).downcase)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return unless @group.group_creator == current_user.account

    if @group.update(group_params)
      redirect_to  group_path(@group),
                   success: I18n.t('flash.update', model: i18n_model_name(@group).downcase)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @group.group_creator == current_user.account
    return unless @group.destroy

    redirect_to account_groups_path(current_user.account),
                success: I18n.t('flash.destroy', model: i18n_model_name(@group).downcase)
  end

  private

  def define_account!
    @account = Account.find_by user_id: current_user.id
  end

  def define_group!
    @group = Group.find(params[:id]).decorate
  end

  def become_group_participant
    @account = Account.find_by user_id: current_user.id
    @group.accounts << @account unless @group.accounts.exists?(@account.id)
  end
  helper_method :become_group_participant

  def group_params
    params.require(:group).permit(:name_group, :description, :visibility,
                                  hobbies_attributes: %i[id hobby_name _destroy])
  end
end
