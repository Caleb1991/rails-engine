FactoryBot.define do
  factory :invoice do
    status {}
    customer
    merchant
  end
end
