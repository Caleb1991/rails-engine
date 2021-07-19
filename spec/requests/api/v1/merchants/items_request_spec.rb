require 'rails_helper'

describe 'Merchant Items API' do
  it 'returns the items for a given merchant' do
    new = create(:merchant)
    item = create(:item, merchant: new)

    get "/api/v1/merchants/#{new.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(1)
  end
end
