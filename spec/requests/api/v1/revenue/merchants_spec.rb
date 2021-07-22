require 'rails_helper'

RSpec.describe 'Merchant API' do
  it 'sends merchants with most revenue' do
    
    get '/api/v1/revenue/merchants?quantity=3'

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect()
  end
end
