require 'rails_helper'

describe 'Items API' do
  it 'sends all items 20 per page by default' do
    create_list(:item, 35)

    get '/api/v1/items'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(20)
  end

  it 'can take in just limit params' do
    create_list(:item, 35)

    get '/api/v1/items?per_page=15'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(15)
  end

  it 'can take in just page number params' do
    create_list(:item, 35)

    get '/api/v1/items?page_number=2'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(15)
  end

  it 'can take in both params' do
    create_list(:item, 35)

    get '/api/v1/items?page_number=2&per_page=12'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(12)
  end

  it 'defaults to 20 when given zero limit' do
    create_list(:item, 35)

    get '/api/v1/items?per_page=0'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(20)
  end

  it 'defaults to one when given zero as a page_number' do
    create_list(:item, 35)

    get '/api/v1/items?page_number=0'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(20)
  end

  it 'defaults to 1 when given negative page_limits' do
    create_list(:item, 35)

    get '/api/v1/items?page_number=-1'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(20)
  end

  it 'defaults to 20 when given negative limits' do
    create_list(:item, 35)

    get '/api/v1/items?per_page=-1'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one[:data].count).to eq(20)
  end

  it 'sends a given item' do
    new = create(:item)

    get "/api/v1/items/#{new.id}"

    expect(response). to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(new.name).to eq(item[:data][:attributes][:name])
    expect(new.description).to eq(item[:data][:attributes][:description])
    expect(new.unit_price).to eq(item[:data][:attributes][:unit_price])
    expect(new.merchant_id).to eq(item[:data][:attributes][:merchant_id])
  end

  it 'can create an item' do
    merchant = create(:merchant)
    item_params = ({
      name: 'Roalds Ropes',
      description: 'Much strong.',
      unit_price: 10.5,
      merchant_id: merchant.id
      })

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate({item: item_params})

      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end

  it 'can edit an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    previous_name = Item.last.name
    new_name = { name: 'Roalds Ropes'}
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: new_name})
    item = Item.find(item.id)

    expect(response).to be_successful
    expect(item.name).to eq(new_name[:name])
    expect(item.name).to_not eq(previous_name)
  end

  it 'destroys an item' do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'sends the all results for a given search' do
    merchant = create(:merchant)
    item_1 = Item.create!(name: "Roald's Rings", description: 'A great buy', unit_price: 1300, merchant_id: merchant.id)
    item_2 = Item.create!(name: "Another Seller", description: 'Bring out the best', unit_price: 1400, merchant_id: merchant.id)
    item_2 = Item.create!(name: "test", description: 'test', unit_price: 1400, merchant_id: merchant.id)

    get '/api/v1/items/find_all?name=ring'

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(results[:data].count).to eq(2)
    expect(results[:data][0][:attributes][:name]).to eq(item_1.name)
    expect(results[:data][1][:attributes][:name]).to eq(item_2.name)
  end
end
