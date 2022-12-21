# frozen_string_literal: true

class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :define_variables!
  before_action :define_comment!, except: %i[create]
  helper_method :commentable_path

  def edit; end

  def create
    @comment = @commentable.comments.build comment_params
    @comment.author_comment = @account

    if @comment.save
      redirect_to commentable_path(@comment),
                  success: I18n.t('flash.new', model: i18n_model_name(@comment).downcase)
    else
      redirect_to commentable_path(@comment),
                  danger: @comment.errors.full_messages.each(&:capitalize).join(' ').to_s
    end
  end

  def update
    return unless @comment.author_comment == @account

    if @comment.update comment_params
      redirect_to commentable_path(@comment),
                  success: I18n.t('flash.update', model: i18n_model_name(@comment).downcase)
    else
      redirect_to commentable_path(@comment),
                  danger: @comment.errors.full_messages.each(&:capitalize).join(' ').to_s
    end
  end

  def destroy
    return unless @comment.destroy

    redirect_to commentable_path(@comment),
                success: I18n.t('flash.destroy', model: i18n_model_name(@comment).downcase)
  end

  private

  def define_comment!
    @comment = Comment.find params[:id]
  end

  def define_variables!
    @account = Account.find_by user_id: current_user.id

    # set commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def commentable_path(comment)
    return post_path(comment.commentable, anchor: dom_id(comment)) if comment.commentable_type == 'Post'
    return content_path(comment.commentable, anchor: dom_id(comment)) if comment.commentable_type == 'Content'
  end
  helper_method :commentable_path

  def comment_params
    params.require(:comment).permit(:body)
  end
end
