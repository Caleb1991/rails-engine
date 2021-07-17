class Api::V1::Items::MerchantController < ApplicationController
  def index
    item = Item.find(params[:id])

    render json: item.merchant
  end
end
