class Api::V1::MerchantsController < ApplicationController
  def index
    binding.pry
    render json: Merchant.all.limit(params[:limit]).offset((params[:page_number].to_i - 1)*params[:limit].to_i)
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
