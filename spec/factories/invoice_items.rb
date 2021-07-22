FactoryBot.define do
  factory :invoice_item do
    quantity {}
    unit_price {}
    item
    invoice
  end
end
