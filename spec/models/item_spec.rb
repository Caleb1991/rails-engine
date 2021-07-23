require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should belong_to(:merchant)}
  end
  describe 'class methods' do
    describe 'items_displayed_per_page' do
      it 'returns a given number of merchants with offset where applicable' do
        merchant = create(:merchant)
        create_list(:item, 30, merchant: merchant)
        result = Item.items_displayed_per_page(15, 1)

        expect(result.count).to eq(15)
        expect(result.first).to eq(Item.first)
        expect(result.last).to_not eq(Item.last)
      end
    end
  end
end
