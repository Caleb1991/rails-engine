class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    render json: Merchant.most_revenue(params[:quantity])
  end
end
