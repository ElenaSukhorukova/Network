# frozen_string_literal: true

module Accounts
  class HobbiesController < ApplicationController
    before_action :authenticate_user!
    before_action :define_account!
    include HobbyAdd

    def new
      @hobby = Hobby.new
    end

    def create
      @hobby = Hobby.new_hobby hobby_params
      path = account_path(@account)
      if @hobby.save
        hobby_add(@account, @hobby)

        return redirect_to path, success: I18n.t('flash.new', model: i18n_model_name(@hobby).downcase)
      end
      redirect_to path, danger: @hobby.errors.full_messages.each(&:capitalize).join(' ').to_s
    end

    private

    def define_account!
      @account = current_user.account
    end

    def hobby_params
      params.require(:hobby).permit(:hobby_name)
    end
  end
end
