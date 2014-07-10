require_relative 'repository'
require_relative 'invoice'
require_relative 'invoice_item'

class InvoiceRepository < Repository
  extend RepositoryAccessors

  def self.create(args)
    new_invoice_id = all.max_by(&:id).id + 1
    time = Time.now.to_s
    invoice_item_repository.create_all(new_invoice_id, Array(args[:items]))
    invoice = Invoice.new(id: new_invoice_id, customer_id: args[:customer].id,
                 merchant_id: args[:merchant].id, status: args[:status],
                  created_at: time, updated_at: time)
    all << invoice
    invoice
  end

  def self.pending
    all.reject(&:successful?)
  end

  def self.average_revenue(date = nil)
    successful = []
    if date
      successful = all.select { |x| Date.parse(x.created_at) == date }
                      .select(&:successful?)

    else
      successful = all.select(&:successful?)
    end
    total = successful.flat_map(&:invoice_items)
                      .reduce(0) { |sum, x| sum + (x.quantity * x.unit_price) }
    (total / successful.count).round(2)
  end

  def self.average_items(date = nil)
    successful = []
    if date
      successful = all.select { |x| Date.parse(x.created_at) == date }
                      .select(&:successful?)

    else
      successful = all.select(&:successful?)
    end
    total = successful.flat_map(&:invoice_items)
                      .reduce(0) { |sum, x| sum + x.quantity }
    (BigDecimal.new(total) / successful.count).round(2)
  end
end
