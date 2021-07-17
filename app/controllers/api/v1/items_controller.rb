class Api::V1::ItemsController < ApplicationController
  def index
    if params.include?(:page_number)
      render json: Item.all.items_displayed_per_page(20, params[:page_number])
    elsif params.include?(:limit)
      render json: Item.all.items_displayed_per_page(params[:limit])
    elsif params.include?(:limit) && params.include?(:page_number)
      render json: Item.all.items_displayed_per_page(params[:limit], params[:page_number])
    else
      render json: Item.all.items_displayed_per_page
    end
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    render json: Item.create(item_params)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def destroy
    Item.delete(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
