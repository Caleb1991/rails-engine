class Api::V1::ItemsController < ApplicationController
  def index
    if params[:page] && params[:page].to_i <= 0
      params[:page] = 1
    end

    if params[:per_page] && params[:per_page].to_i <= 0
      params[:per_page] = 20
    end

    if params[:per_page] && params[:page]
      items = Item.all.items_displayed_per_page(params[:per_page], params[:page])
      render json: ItemSerializer.new(items)
    elsif params[:page]
      items = Item.all.items_displayed_per_page(20, params[:page])
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
    item = Item.create!(item_params)

    if item.save
      render json: ItemSerializer.new(item), status: 201
    end
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    Item.delete(params[:id])
  end

  def search
    items = Item.where('(lower(name) like ?) OR (lower(description) like ?)', "%#{params[:name].downcase}%", "%#{params[:name].downcase}%")

    if items
      render json: ItemSerializer.new(items)
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
