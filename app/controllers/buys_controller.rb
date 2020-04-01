class BuysController < ApplicationController
  def index
    @buys = Buy.includes(:user)
    @buys = params[:tag_id].present? ? Tag.find(params[:tag_id]).buys : Buy.all
  end

  def new
    @buy = Buy.new
    buy_tags = @buy.buy_tags.build
  end

  def create
    @buy = Buy.new(buy_params)
    if @buy.save
      redirect_to buys_path, method: :post
    else
      render :new
    end
  end

  def show
    @buy = Buy.find(params[:id])
    @comment = Comment.new
    @comments = @buy.comments.includes(:user)
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
