class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    merchant = Merchant.find(params[:id])

    render json: MerchantTotalRevenueSerializer.new(merchant)
  end
end
