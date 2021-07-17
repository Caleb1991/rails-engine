class Api::V1::Item::MerchantsController < ApplicationController
  def show
    item = Item.find(params[:id])

    render json: item.merchant
  end
end
