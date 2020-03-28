class BuysController < ApplicationController
  def index
    @buys = Buy.includes(:user)
  end

  def new
    @buy = Buy.new
    buy_tags = @buy.buy_tags.build
  end

  def create
    Buy.create(buy_params)
  end

  def show
    @buy = Buy.find(params[:id])
  end

  def edit
    @buy = Buy.find(params[:id])
    buy_tags = @buy.buy_tags
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
    params.require(:buy).permit(:goods, :price, :image, :description, buy_tags_attributes: [:buy_id, :tag_id, :_destroy, :id]).merge(user_id: current_user.id)
  end
end
