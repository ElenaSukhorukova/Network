class Groups::HobbiesController < ApplicationController
  before_action :authenticate_user!
  before_action :define_group!

  def new
    @hobby = Hobby.new
  end

  def create
    @hobby = Hobby.new_hobby hobby_params
    if @hobby.save
      @group.hobbies << @hobby unless @group.hobbies.find_by(hobby_name: @hobby.hobby_name)
      redirect_to group_path(@group),
        success: I18n.t('flash.new', model: i18n_model_name(@hobby).downcase)
    else
      redirect_to group_path(@group),
      danger: "#{@hobby.errors.full_messages.each{|error| error.capitalize}.join(' ')}"
    end
  end

  private

  def define_group!
    @group = Group.find params[:group_id]
  end

  def hobby_params
    params.require(:hobby).permit(:hobby_name)
  end
end