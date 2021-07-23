class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.merchants_displayed_per_page(limit_params = 20, page_params = 1)
    limit(limit_params).offset((page_params.to_i - 1)*limit_params.to_i)
  end

  def self.most_revenue(limit)
     joins(:invoices, :invoice_items, :transactions)
    .select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
    .group(:id)
    .where(transactions: {result: 'success'})
    .order(total_revenue: :desc)
    .limit(limit)
  end

  def self.most_items_sold_by_merchant(limit = 5)
     joins(:invoice_items, :transactions)
    .select('merchants.*, SUM(invoice_items.quantity) AS total_items_sold')
    .group(:id)
    .where(transactions: {result: 'success'})
    .order(total_items_sold: :desc)
    .limit(limit)
  end

  def total_revenue_by_merchant
     invoices
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
