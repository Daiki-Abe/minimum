class BuysController < ApplicationController
  def index
  end

  def new
    @buy = Buy.new
  end

  def create
    Buy.create(buy_params)
  end

  def show
  end

  private
  def buy_params
    params.require(:Buy).permit(:goods, :price, :image, :description).merge(user_id: current_user.id)
  end
end
