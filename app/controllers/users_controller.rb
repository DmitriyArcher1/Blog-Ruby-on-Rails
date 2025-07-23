class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show ]

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @blog_posts = @user.blog_posts.order(created_at: :desc)
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
