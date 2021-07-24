class MerchantTotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :id

  attribute :revenue do |object|
    object.total_revenue_by_merchant
  end
end
