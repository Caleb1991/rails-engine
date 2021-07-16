class Item < ApplicationRecord
  belongs_to :merchant

  def self.items_displayed_per_page(limit_params, page_params)
    limit(limit_params).offset((page_params.to_i - 1)*limit_params.to_i)
  end
end
