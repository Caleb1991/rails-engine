class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page_number] && params[:page_number].to_i <= 0
      params[:page_number] = 1
    end

    if params[:limit] && params[:limit].to_i <= 0
      params[:limit] = 20
    end

    if params.include?(:limit) && params.include?(:page_number)
      render json: Merchant.all.merchants_displayed_per_page(params[:limit], params[:page_number])
    elsif params.include?(:page_number)
      render json: Merchant.all.merchants_displayed_per_page(20, params[:page_number])
    elsif params.include?(:limit)
      render json: Merchant.all.merchants_displayed_per_page(params[:limit])
    else
      render json: Merchant.all.merchants_displayed_per_page
    end
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
