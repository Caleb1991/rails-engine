class Api::V1::MerchantsController < ApplicationController
  def index
    if params.include?(:page_number)
      render json: Merchant.all.merchants_displayed_per_page(20, params[:page_number])
    elsif params.include?(:limit)
      render json: Merchant.all.merchants_displayed_per_page(params[:limit])
    elsif params.include?(:limit) && params.include?(:page_number)
      render json: Merchant.all.merchants_displayed_per_page(params[:limit], params[:page_number])
    else
      render json: Merchant.all.merchants_displayed_per_page
    end
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
