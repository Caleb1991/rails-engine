require 'rails_helper'

describe 'Merchant API' do
  it 'sends all merchants 20 at a time' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?page_number=1&limit=20'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)
  end

  it 'sends one merchant' do
    new = create(:merchant)

    get "/api/v1/merchants/#{new.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(new.name).to eq(merchant[:name])
  end
end
