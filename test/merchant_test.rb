require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/invoice'
require_relative '../lib/invoice_item'
require_relative '../lib/transaction'
require_relative '../lib/item'

class MerchantTest < MiniTest::Test
  def data
    { id: '1', name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
  end

  def test_can_create_a_merchant
    m = Merchant.new(data)

    assert_equal 1, m.id
    assert_equal 'Best Buy', m.name
    assert m.created_at
    assert m.updated_at
  end

  def test_we_can_find_items_belonging_to_merchant
    ItemRepository.load('test/fixtures/items.csv', Item)
    items = Merchant.new(data).items
    assert_equal 2, items.count

    item1, item2 = items
    assert_equal 'Item Qui Esse', item1.name
    assert_equal 'Item Autem Minima', item2.name
  end

  def test_we_can_find_invoices_belonging_to_merchant
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    invoices = Merchant.new(data).invoices

    invoice1, invoice2 = invoices

    assert_equal 4, invoices.count
    assert_equal 'shipped', invoice1.status
    assert_equal 2, invoice2.id
  end

  def test_we_can_find_the_total_revenue
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    TransactionRepository.load('test/fixtures/transactions.csv', Transaction)
    InvoiceItemRepository.load('test/fixtures/invoice_items.csv', InvoiceItem)

    m = Merchant.new(data)
    assert_equal 1645131.0, m.revenue
  end

  def test_we_can_find_total_revenue_on_a_given_date
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    TransactionRepository.load('test/fixtures/transactions.csv', Transaction)
    InvoiceItemRepository.load('test/fixtures/invoice_items.csv', InvoiceItem)

    date = Date.parse("2012-03-10")
    m = Merchant.new(data)
    assert_equal 527488, m.revenue(date)
  end

  def test_we_can_find_customers_with_unpaid_invoices
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    TransactionRepository.load('test/fixtures/transactions.csv', Transaction)
    CustomerRepository.load('test/fixtures/customers.csv', InvoiceItem)

    m = Merchant.new(data)
    # assert_equal "Loyal", m.customers_with_pending_invoices
    assert_equal 1, m.customers_with_pending_invoices.count
  end
end
