require_relative 'repository_accessors'
require 'bigdecimal'

class Item
  include RepositoryAccessors

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price].to_i) / 100.0
    @merchant_id = data[:merchant_id].to_i
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def merchant
    merchant_repository.find_by_id(merchant_id)
  end

  def invoice_items
    invoice_item_repository.find_all_by_item_id(id)
  end

  def best_day
    grouped = invoice_items.select(&:successful?).group_by(&:created_at)
    invoice_items = grouped.max_by do |_, items|
      items.inject(0) { |sum, item| sum + item.quantity }
    end.last
    Date.parse(invoice_items.first.invoice.created_at)
  end
end
