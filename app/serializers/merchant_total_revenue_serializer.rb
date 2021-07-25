class MerchantTotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  set_type :merchant_revenue
  attribute :revenue do |object|
    object.total_revenue_by_merchant
  end
end
