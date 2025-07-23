class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :new, :update, :destroy ]
  before_action :authorize_user, only: [ :edit, :update, :destroy ]
  def index
    @blog_posts = BlogPost.all
  end

  def show
  end

  def new
    @blog_post = current_user.blog_posts.build
  end

  def create
    @blog_post = current_user.blog_posts.build(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post, notice: "Пост успешно изменён"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :image)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authorize_user
    unless @blog_post.user == current_user
      redirect_to root_path, alert: "У вас нет доступа, чтобы выполнить это действите"
    end
  end
end
