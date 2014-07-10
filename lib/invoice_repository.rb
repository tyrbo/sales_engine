require_relative 'repository'
require_relative 'invoice'
require_relative 'invoice_item'

class InvoiceRepository < Repository
  extend RepositoryAccessors

  def self.create(args)
    new_invoice_id = all.max_by(&:id).id + 1
    time = Time.now.to_s
    invoice_item_repository.create_all(new_invoice_id, args[:items])
    invoice = Invoice.new(id: new_invoice_id, customer_id: args[:customer].id, merchant_id: args[:merchant].id, status: args[:status], created_at: time, updated_at: time)
    all << invoice
    invoice
  end
end
