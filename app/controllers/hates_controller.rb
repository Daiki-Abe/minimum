class HatesController < ApplicationController
  before_action :set_buy, only: [:create, :destroy]

  def create
    @hate = Hate.create(user_id: current_user.id, buy_id: @buy.id)
  end

  def destroy
    @hate = Hate.find_by(user_id: current_user.id, buy_id: @buy.id)
    @hate.destroy
  end

  private

  def set_buy
    @buy = Buy.find(params[:buy_id])
  end
end
