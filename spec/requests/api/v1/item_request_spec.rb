require 'rails_helper'

describe 'Items API' do
  it 'sends all items 20 per page' do
    create_list(:item, 35)

    get '/api/v1/items/1/20'

    expect(response).to be_successful
    items_page_one = JSON.parse(response.body, symbolize_names: true)

    expect(items_page_one.count).to eq(20)
  end

  it 'sends a given item' do
    new = create(:item)

    get "/api/v1/items/#{new.id}"

    expect(response). to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(new.name).to eq(item[:name])
    expect(new.description).to eq(item[:description])
    expect(new.unit_price).to eq(item[:unit_price])
    expect(new.merchant_id).to eq(item[:merchant_id])
  end

  it 'can create an item' do
    item_params = ({
      name: 'Roalds Ropes',
      description: 'Much strong.',
      unit_price: 10.5,
      merchant_id: 1
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
    item = create(:item)
    previous_name = Item.last.name
    new_name = { name: 'Roalds Ropes'}
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({name: new_name})
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
end
