class BuysController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  def index
    @buys = params[:tag_id].present? ? Tag.find(params[:tag_id]).buys.includes(:user).order("created_at DESC").page(params[:page]).per(18) : Buy.includes(:user).order("created_at DESC").page(params[:page]).per(18)
  end

  def new
    @buy = Buy.new
    buy_tags = @buy.buy_tags.build
  end

  def create
    @buy = Buy.new(buy_params)
    @buy.save
    render :new unless @buy.save
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
    @buy = Buy.find(params[:id])
    @buy.update(buy_params)
    render :edit unless @buy.update(buy_params)
  end

  def destroy
    buy = Buy.find(params[:id])
    buy.destroy
  end

  def search
    @buys = Buy.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(18)
  end

  private
  def buy_params
    params.require(:buy).permit(:goods, :price, :image, :description, buy_tags_attributes: [:buy_id, :tag_id, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? 
  end
end
