class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_to_subscribe = User.find(params[:subscription][:subscribed_to_id])

    if current_user == @user_to_subscribe
      flash[:alert] = "Вы не можете подписаться на самого себя."
      redirect_to root_path
      nil
    end
    @subscription = current_user.subscriptions.build(subscribed_to: @user_to_subscribe)

    if @subscription.save
      flash[:alert] = "Успешная подписка!"
      render json: @subscription
    else
      flash[:alert] = "Не удалось подписаться."
      render json: @subscription
    end

    redirect_to root_path
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])

    if @subscription.subscrber == current_user
      @subscription.destroy
      flash[:notice] = "Успешная отписка."
      render json: @subscription
    else
      flash[:alert] = "Не удалось отписаться."
      render json: @subscription
    end

    redirect_to root_path
  end
end
