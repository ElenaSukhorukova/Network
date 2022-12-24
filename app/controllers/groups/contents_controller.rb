# frozen_string_literal: true

module Groups
  class ContentsController < ApplicationController
    before_action :authenticate_user!
    before_action :define_content!, except: %i[new create]
    before_action :define_group!, only: %i[new create]
    before_action :define_account!

    def show
      @group = @content.group
      @pagy_comment, @comments = pagy @content.comments.order_desc, items: 4, page_param: :pagy_comment
      @comments = @comments.decorate
    end

    def new
      @content = @group.contents.build
    end

    def edit; end

    def create
      @content = @group.contents.build content_params
      @content.account = @account
      if @content.save
        redirect_to content_path(@content),
                    success: I18n.t('flash.new', model: i18n_model_name(@content).downcase)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      return unless @account == @content.account

      if @content.update content_params
        redirect_to content_path(@content),
                    success: I18n.t('flash.update', model: i18n_model_name(@content).downcase)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      return unless @content.destroy

      redirect_to group_path(@group),
                  success: I18n.t('flash.destroy', model: i18n_model_name(@content).downcase)
    end

    private

    def define_content!
      @content = Content.find(params[:id]).decorate
    end

    def define_group!
      @group = Group.find params[:group_id]
    end

    def define_account!
      @account = Account.find_by user_id: current_user.id
    end

    def content_params
      params.require(:content).permit(:body)
    end
  end
end
