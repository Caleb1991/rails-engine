require 'rails_helper'

describe 'Merchant by Item API' do
  it 'returns a merchants show page with a given item' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_1_item = Item.create(name: 'This', description: 'Wicked Awesome', unit_price: 10.5, merchant_id: merchant_1.id)
    merchant_2_item = Item.create(name: 'This', description: 'Wicked Awesome', unit_price: 10.5, merchant_id: merchant_2.id)

    get "/api/v1/item/#{merchant_1_item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:name]).to eq(merchant_1.name)
    expect(merchant[:name]).to_not eq(merchant_2.name)
  end
end
