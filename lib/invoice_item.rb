require_relative 'repository_accessors'
require 'bigdecimal'

class InvoiceItem
  include RepositoryAccessors

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price].to_i) / 100.0
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def item
    item_repository.find_by_id(item_id)
  end

  def invoice
    invoice_repository.find_by_id(invoice_id)
  end

  def total
    unit_price * quantity
  end
end
