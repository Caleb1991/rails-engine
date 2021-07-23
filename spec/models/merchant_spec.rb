require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    create_list(:merchant, 20)
  end
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    describe 'merchants_displayed_per_page' do
      it 'returns a given number of merchants with offsets if applicable' do
        result = Merchant.merchants_displayed_per_page(15, 1)

        expect(result.count).to eq(15)
        expect(result.first).to eq(Merchant.first)
        expect(result.last).to_not eq(Merchant.last)
      end
    end

    describe 'most_revenue' do
      it 'returns merchants ordered by most revenue descending' do
        merchant_1 = Merchant.last
        merchant_2 = Merchant.first
        item_1 = Item.create!(name: 'test', description: 'test', unit_price: 1233, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'other test', description: 'other test', unit_price: 1200, merchant_id: merchant_2.id)
        customer_1 = Customer.create!(first_name: 'Roald', last_name: 'Roaldington')
        customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Larryington')
        invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id, status: 'shipped')
        invoice_2 = Invoice.create!(customer_id: customer_2.id, merchant_id: merchant_2.id, status: 'shipped')
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 100, unit_price: 1029)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 10)
        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '12434121', credit_card_expiration_date: '11/11', result: 'success')
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '90893722', credit_card_expiration_date: '11/11', result: 'success')

        result = Merchant.most_revenue(2)

        expect(result.first).to eq(Merchant.last)
      end
    end

    describe 'most_items_sold_by_merchant' do
      it 'returns merchants who sold the most itrems in decending order' do
        merchant_1 = Merchant.last
        merchant_2 = Merchant.first
        item_1 = Item.create!(name: 'test', description: 'test', unit_price: 1233, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'other test', description: 'other test', unit_price: 1200, merchant_id: merchant_2.id)
        customer_1 = Customer.create!(first_name: 'Roald', last_name: 'Roaldington')
        customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Larryington')
        invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id, status: 'shipped')
        invoice_2 = Invoice.create!(customer_id: customer_2.id, merchant_id: merchant_2.id, status: 'shipped')
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 100, unit_price: 1029)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 10)
        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '12434121', credit_card_expiration_date: '11/11', result: 'success')
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '90893722', credit_card_expiration_date: '11/11', result: 'success')

        result = Merchant.most_items_sold_by_merchant(2)

        expect(result.first).to eq(Merchant.last)
      end
    end
  end

  describe 'instance methods' do
    describe 'total_revenue_by_merchant' do
      it 'returns the revenue for a given merchant' do
        merchant_1 = Merchant.last
        merchant_2 = Merchant.first
        item_1 = Item.create!(name: 'test', description: 'test', unit_price: 1233, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'other test', description: 'other test', unit_price: 1200, merchant_id: merchant_2.id)
        customer_1 = Customer.create!(first_name: 'Roald', last_name: 'Roaldington')
        customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Larryington')
        invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id, status: 'shipped')
        invoice_2 = Invoice.create!(customer_id: customer_2.id, merchant_id: merchant_2.id, status: 'shipped')
        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 100, unit_price: 1029)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 10)
        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '12434121', credit_card_expiration_date: '11/11', result: 'success')
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '90893722', credit_card_expiration_date: '11/11', result: 'success')

        result = merchant_1.total_revenue_by_merchant

        expect(result).to eq((100 * 1029))
      end
    end
  end
end
