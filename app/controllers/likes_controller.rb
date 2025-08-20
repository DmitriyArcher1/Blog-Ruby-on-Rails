class LikesController < ApplicationController
  # before_action :set_post
  before_action :authenticate_user!

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @like = @blog_post.likes.build(user: current_user)

    if @like.save
      redirect_to root_path, notice: "Пост понравился!"
    else
      redirect_to root_path, alert: "Не удалось поставить лайк."
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:blog_post_id])
    @like = @blog_post.likes.find_by(user: current_user, id: params[:id])
    # @like = Like.find(params[:id])
    # @blog_post = @like.blog_post

    if @like
      @like.destroy
      redirect_to root_path, notice: "Лайк удалён"
    else
      redirect_to root_path, alert: "Не удалось удалить лайк"
    end
  end

  private

  def like_params
    params.require(:like).permit(:blog_post_id)
  end

  # def set_post
  #   @blog_post = BlogPost.find(params[:blog_post_id])
  # end
end
