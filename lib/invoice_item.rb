require_relative 'repository_accessors'

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
    @id         = data[:id]
    @item_id    = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity   = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def item
    item_repository.find_by_id(item_id)
  end

  def invoice
    invoice_repository.find_by_id(invoice_id)
  end
end
