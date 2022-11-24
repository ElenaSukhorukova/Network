class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :define_post, except: %i[index new create]
  before_action :define_account, only: %i[new create index]

  def index
    @posts = Post.all.where(place: 'content').order(created_at: :desc)
  end

  def show
    @comment = @post.comments.build
    @comments = Comment.all
  end

  def new 
    @post = @account.posts.build
  end

  def create
    @post = @account.posts.build(post_params)
    
    if @post.save     
      redirect_to posts_path, 
        success: I18n.t('flash.new', model: i18n_model_name(@post).downcase)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post),
        success: I18n.t('flash.update', model: i18n_model_name(@post).downcase)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, 
        success: I18n.t('flash.destroy', model: i18n_model_name(@post).downcase)
    end
  end

  private
    def define_post
      @post = Post.find(params[:id])
    end

    def define_account
      @account = Account.find_by(user_id: current_user.id) if user_signed_in?
    end

    def post_params
      params.require(:post).permit(:body, :place)
    end
end
