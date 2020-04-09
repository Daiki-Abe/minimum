class BuysController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_buy, only: [:show, :edit, :update, :destroy]
  
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
    @comment = Comment.new
    @comments = @buy.comments.includes(:user)
  end

  def edit
    buy_tags = @buy.buy_tags
  end

  def update
    @buy.update(buy_params)
    render :edit unless @buy.update(buy_params)
  end

  def destroy
    @buy.destroy
  end

  def search
    @buys = Buy.search(params[:keyword]).order("created_at DESC").page(params[:page]).per(18)
  end

  private
  def buy_params
    params.require(:buy).permit(:goods, :price, :image, :description, buy_tags_attributes: [:buy_id, :tag_id, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_buy
    @buy = Buy.find(params[:id])
  end

end
