class BuysController < ApplicationController
  def index
    @buys = Buy.includes(:user)
  end

  def new
    @buy = Buy.new
  end

  def create
    Buy.create(buy_params)
  end

  def show
    @buy = Buy.find(params[:id])
  end

  def edit
    @buy = Buy.find(params[:id])
  end

  def update
    buy = Buy.find(params[:id])
    buy.update(buy_params)
  end

  def destroy
    buy = Buy.find(params[:id])
    buy.destroy
  end

  def search
    @buys = Buy.search(params[:keyword])
  end

  private
  def buy_params
    params.require(:buy).permit(:goods, :price, :image, :description).merge(user_id: current_user.id)
  end
end
