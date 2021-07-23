require 'rails_helper'

RSpec.describe 'Merchant API' do
  it 'sends merchants with most revenue' do

    get '/api/v1/revenue/merchants?quantity=3'

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end

  xit 'sends the total revenue for a given merchant' do
    merchant = create(:merchant)
    item = Item.create!(name: 'Roalds Razors', description: 'Sharp as a tack', unit_price: 1200, merchant_id: merchant.id)
    customer = Customer.create!(first_name: 'Larry', last_name: 'Larryson')
    invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: 'shipped')
    invoice_items = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 30, unit_price: 1299)
    Transaction.create!(invoice_id: invoice.id, credit_card_number: '102938347', credit_card_expiration_date: '11/11', result: 'success')

    get "/api/v1/revenue/merchants/#{merchant.id}"

    result = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(response).to be_successful
  end
end
