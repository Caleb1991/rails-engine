class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def self.merchants_displayed_per_page(limit_params = 20, page_params = 1)
    limit(limit_params).offset((page_params.to_i - 1)*limit_params.to_i)
  end
end
