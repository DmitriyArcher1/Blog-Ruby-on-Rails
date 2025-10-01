class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :show_subs ]

  def index
    @users = User.all

    render json: @users
  end

  def show
    @user = current_user
    @blog_posts = @user.blog_posts.order(created_at: :desc)

    render json: @user
  end

  def show_subs
    @subscribed_posts = BlogPost.where(user: @user.subscribed_users).order(created_at: :desc)

    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
    if @user.nil?
      flash[:alert] = "Пользователь не найден"
      redirect_to root_path
      nil
    end
  end
end
