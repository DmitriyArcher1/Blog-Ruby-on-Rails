class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @blog_post.likes.build
    if @like.save
      redirect_to root_path, notice: "Пост понравился!"
    else
      redirect_to root_path, alert: "Не удалось поставить лайк."
    end
  end

  def destroy
    @like = @blog_post.likes.find_by(id: params[:id])
    if @like&.destroy
      redirect_to root_path, notice: "Лайк удален."
    else
      redirect_to root_path, notice: "Не удалось удалить лайк."
    end
  end

  private

  def set_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end
end
