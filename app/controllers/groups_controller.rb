class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account, except: %i[edit update destroy]
  before_action :define_group, except: %i[index new create]

  def index
    @created_groups = Group.where(group_creator_id: @account.id)
    @participation_groups = @account.groups.where.not(group_creator_id: @account.id)
  end

  def show
  end

  def new
    @group = @account.groups.build
    3.times { @group.interests.build }
  end
  
  def create
    @group = @account.groups.build(group_params)
    if @group.save
      redirect_to group_path(@group), 
      success: I18n.t('flash.new', model: i18n_model_name(@group).downcase)
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @group.group_creator == current_user.account
      if @group.update(group_params)
        redirect_to  group_path(@group),
          success: I18n.t('flash.update', model: i18n_model_name(@group).downcase)
      else 
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @group.group_creator == current_user.account
      if @group.destroy
        redirect_to account_groups_path(current_user.account), 
          success: I18n.t('flash.destroy', model: i18n_model_name(@group).downcase)
      end
    end
  end

  private
    
    def define_account
      @account = Account.find_by(user_id: current_user.id)
    end

    def define_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name_group, :description, :visibility,
        interests_attributes: [:id, :name_interest, :_destroy])
    end
end
