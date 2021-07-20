class Api::V1::ItemsController < ApplicationController
  def index
    if params[:page_number] && params[:page_number].to_i <= 0
      params[:page_number] = 1
    end

    if params[:per_page] && params[:per_page].to_i <= 0
      params[:per_page] = 20
    end

    if params[:per_page] && params[:page_number]
      items = Item.all.items_displayed_per_page(params[:per_page], params[:page_number])
      render json: ItemSerializer.new(items)
    elsif params[:page_number]
      items = Item.all.items_displayed_per_page(20, params[:page_number])
      render json: ItemSerializer.new(items)
    elsif params[:per_page]
      items = Item.all.items_displayed_per_page(params[:per_page])
      render json: ItemSerializer.new(items)
    else
      items = Item.all.items_displayed_per_page
      render json: ItemSerializer.new(items)
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create(item_params)

    render json: ItemSerializer.new(item)
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    Item.delete(params[:id])
  end

  def search
    items = Item.where('lower(name) like ?', params[:name].downcase)

    if items
      render json: ItemSerializer.new(items)
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
