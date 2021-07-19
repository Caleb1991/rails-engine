require 'rails_helper'

describe 'Merchant API' do
  it 'sends all merchants 20 at a time by default' do
    create_list(:merchant, 35)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)
  end

  it 'can take in just limit params' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?limit=15'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(15)
  end

  it 'can take in just page number params' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?page_number=2'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(15)
  end

  it 'can take in both params' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?page_number=2&limit=15'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(15)
  end

  it 'handles zero limits' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?limit=0'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)
  end

  it 'handles zero page number' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?page_number=0'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)
  end

  it 'handles negative limits' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?limit=-1'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)
  end

  it 'handles negative page numbers' do
    create_list(:merchant, 35)

    get '/api/v1/merchants?page_number=-1'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)
  end

  it 'sends one merchant' do
    new = create(:merchant)

    get "/api/v1/merchants/#{new.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(new.name).to eq(merchant[:data][:attributes][:name])
  end

  it 'returns the top result for a name search' do
    merchant_1 = Merchant.create(name: 'Soald')
    merchant_2 = Merchant.create!(name: 'Roald')

    get '/api/v1/merchants/find?name=oal'

    expect(response).to be_successful

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:data][:attributes][:name]).to eq('Roald')
  end
end
