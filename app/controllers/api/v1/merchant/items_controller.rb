class Api::V1::Merchant::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])

    render json: merchant.items
  end
end
