class Merchant < ApplicationRecord
  has_many :items

  def self.number_displayed_per_page(limit_params, page_params)
    limit(limit_params).offset((page_params.to_i - 1)*limit_params.to_i)
  end
end
