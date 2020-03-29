class HatesController < ApplicationController
  before_action :set_buy, only: [:create, :destroy]

  def create
    @hate = current_user.hates.create(buy_id: params[:buy_id])
    @buys = Buy.all
  end

  def destroy
    hate = current_user.hates.find_by(buy_id: params[:buy_id])
    hate.destroy
    @buys = Buy.all
  end

  private

  def set_buy
    @buy = Buy.find(params[:buy_id])
  end
end
