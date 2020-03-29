class HatesController < ApplicationController
  before_action :set_buy, only: [:create, :destroy]

  def create
    @buys = Buy.all
    @hate = current_user.hates.create(buy_id: params[:buy_id])
    redirect_to buy_path
  end

  def destroy
    @buys = Buy.all
    hate = current_user.hates.find_by(buy_id: params[:buy_id])
    hate.destroy
    redirect_to buy_path
  end

  private

  def set_buy
    @buy = Buy.find(params[:buy_id])
  end
end
