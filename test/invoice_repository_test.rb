require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test
  include RepositoryAccessors

  def setup
    invoice_repository.load(CSVLoader.new('./test/fixtures/invoices.csv'), Invoice)
    invoice_item_repository.load(CSVLoader.new('./test/fixtures/invoice_items.csv'), InvoiceItem)
  end

  def test_it_can_create_new_invoices
    invoice_count = invoice_repository.all.count
    invoice_item_count = invoice_item_repository.all.count
    time = Time.now.to_s

    customer = Customer.new(id: 1000, first_name: 'John', last_name: 'Smith', created_at: time, updated_at: time)
    merchant = Merchant.new(id: 1000, name: 'Wal-Mart', created_at: time, updated_at: time)
    item1 = Item.new(id: 1000, name: 'Seiki UHD 50" TV', description: 'A cheap UHD TV', unit_price: '42000', merchant_id: 1000, created_at: time, updated_at: time)
    item2 = Item.new(id: 1001, name: 'Nexus 5', description: 'A Google phone', unit_price: '30000', merchant_id: 1000, created_at: time, updated_at: time)

    invoice_repository.create(customer: customer, merchant: merchant, status: "shipped",
                                 items: [item1, item2, item1])

    assert_equal (invoice_count + 1), invoice_repository.all.count
    assert_equal (invoice_item_count + 2), invoice_item_repository.all.count
    invoice = invoice_repository.all.last
    assert_equal 1000, invoice.customer_id
    assert_equal 1000, invoice.merchant_id
    assert_equal 'shipped', invoice.status
  end
end
