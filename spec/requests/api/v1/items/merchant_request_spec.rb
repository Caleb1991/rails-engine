require 'rails_helper'

describe 'Merchant by Item API' do
  it 'returns a merchants show page with a given item' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_1_item = create(:item, merchant: merchant_1)
    merchant_2_item = create(:item, merchant: merchant_2)

    get "/api/v1/items/#{merchant_1_item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant_2.name)
  end

  it 'returns the top result for a name search' do
  end
end
