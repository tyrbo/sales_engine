require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  def self.create_all(invoice_id, items)
    time = Time.now.to_s
    items.group_by { |item| item.id }.each do |item_id, items|
      new_id = all.max_by(&:id).id + 1
      invoice_item = InvoiceItem.new(id: new_id, item_id: item_id, invoice_id: invoice_id, quantity: items.count, unit_price: items.first.unit_price, created_at: time, updated_at: time)
      all << invoice_item
    end
  end
end
