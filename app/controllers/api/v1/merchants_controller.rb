class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all.merchants_displayed_per_page(params[:limit], params[:page_number])
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
