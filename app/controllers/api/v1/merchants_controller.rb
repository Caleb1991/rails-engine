class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page] && params[:page].to_i <= 0
      params[:page] = 1
    end

    if params[:per_page] && params[:per_page].to_i <= 0 || params[:per_page] == nil
      params[:per_page] = 20
    end

    if params.include?(:per_page) && params.include?(:page)
      merchants = Merchant.all.merchants_displayed_per_page(params[:per_page], params[:page])
      render json: MerchantSerializer.new(merchants)
    elsif params.include?(:page)
      merchants = Merchant.all.merchants_displayed_per_page(20, params[:page])
      render json: MerchantSerializer.new(merchants)
    elsif params.include?(:per_page)
      merchants = Merchant.all.merchants_displayed_per_page(params[:per_page])
      render json: MerchantSerializer.new(merchants)
    else
      merchants = Merchant.all.merchants_displayed_per_page
      render json: MerchantSerializer.new(merchants)
    end
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def search
    merchant = Merchant.where('lower(name) like ?', "%#{params[:name].downcase}%").order(:name).first

    if merchant
      render json: MerchantSerializer.new(merchant)
    end
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items_sold_by_merchant(params[:quantity]))
  end
end
