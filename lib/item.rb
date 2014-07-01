require_relative 'merchant_repository'
require_relative 'invoice_item_repository'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def merchant
    MerchantRepository.find_by_id(merchant_id)
  end

  def invoice_items
    InvoiceItemRepository.find_all_by_item_id(id)
  end
end
