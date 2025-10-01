class Api::V1::LikesController < ApplicationController
  before_action :set_post, only: [ :create, :destroy ]
  before_action :authenticate_user!

  def create
    # @blog_post = BlogPost.find(params[:blog_post_id])
    @like = @blog_post.likes.build(user: current_user)

    if @like.save
      redirect_to root_path, notice: "Пост понравился!"
      render json: @like
    else
      redirect_to root_path, notice: "Не удалось поставить лайк"
      render json: @like
    end
  end

  def destroy
    # @blog_post = BlogPost.find(params[:blog_post_id])
    @like = @blog_post.likes.find_by(user: current_user, id: params[:id])

    if @like
      @like.destroy
      redirect_to root_path, notice: "Лайк удалён"
      render json: @like
    else
      redirect_to root_path, alert: "Не удалось удалить лайк"
      render json: @like
    end
  end

  def set_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end
end
