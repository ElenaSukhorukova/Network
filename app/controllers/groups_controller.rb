class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :define_account, except: %i[edit update destroy]

  def index
    @created_groups = Group.where(creator_id: @account)
    @groups = @account.groups.where.not(creator_id: @account)
  end

  def new
    @group = @account.groups.build
    3.times { @group.interests.build }
  end
  
  def create
    @group = @account.groups.build(group_params)
    if @group.save
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    
    def define_account
      @account = Account.find_by(user_id: current_user.id)
    end

    def group_params
      params.require(:group).permit(:name_grou, :description, :visibility,
        interests_attributes: [:id, :name_interest, :_destroy])
    end
end
