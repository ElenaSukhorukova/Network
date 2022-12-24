# frozen_string_literal: true

module Groups
  class HobbiesController < ApplicationController
    before_action :authenticate_user!
    before_action :define_group!
    include HobbyAdd

    def new
      @hobby = Hobby.new
    end

    def create
      @hobby = Hobby.new_hobby hobby_params
      if @hobby.save
        hobby_add(@group, @hobby)
        return redirect_to group_path(@group),
                           success: I18n.t('flash.new', model: i18n_model_name(@hobby).downcase)
      end

      redirect_to group_path(@group),
                  danger: @hobby.errors.full_messages.each(&:capitalize).join(' ').to_s
    end

    private

    def define_group!
      @group = Group.find params[:group_id]
    end

    def hobby_params
      params.require(:hobby).permit(:hobby_name)
    end
  end
end
