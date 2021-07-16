require 'rails_helper'

describe 'Merchant Items API' do
  it 'returns the items for a given merchant' do
    new = create(:merchant)

    get "/api/v1/merchant/#{new.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(0)
  end
end