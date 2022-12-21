# frozen_string_literal: true

module Accounts
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :define_account!
    before_action :define_post!, except: %i[index new create]

    def new
      @post = @account.posts.build
    end

    def create
      @post = @account.posts.build post_params

      if @post.save
        redirect_to account_path(@account),
                    success: I18n.t('flash.new', model: i18n_model_name(@post).downcase)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      return unless @post.destroy

      redirect_to account_path(@account),
                  success: I18n.t('flash.destroy', model: i18n_model_name(@post).downcase)
    end

    private

    def define_post!
      @post = Post.find params[:id]
    end

    def define_account!
      @account = Account.find params[:account_id]
    end

    def post_params
      params.require(:post).permit(:body)
    end
  end
end
