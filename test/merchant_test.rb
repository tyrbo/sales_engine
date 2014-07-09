require_relative 'test_helper'

class MerchantTest < MiniTest::Test
  include RepositoryAccessors

  def setup
    item_repository.load(CSVLoader.new('test/fixtures/items.csv'), Item)
    invoice_repository.load(CSVLoader.new('test/fixtures/invoices.csv'), Invoice)
    transaction_repository.load(CSVLoader.new('test/fixtures/transactions.csv'), Transaction)
    invoice_item_repository.load(CSVLoader.new('test/fixtures/invoice_items.csv'), InvoiceItem)
    customer_repository.load(CSVLoader.new('test/fixtures/customers.csv'), Customer)
  end

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
    items = Merchant.new(data).items
    assert_equal 3, items.count

    item1, item2 = items
    assert_equal 'Item Qui Esse', item1.name
    assert_equal 'Item Autem Minima', item2.name
  end

  def test_we_can_find_invoices_belonging_to_merchant
    invoices = Merchant.new(data).invoices

    invoice1, invoice2 = invoices

    assert_equal 5, invoices.count
    assert_equal 'shipped', invoice1.status
    assert_equal 2, invoice2.id
  end

  def test_we_can_find_the_total_revenue
    m = Merchant.new(data)
    assert_equal 16451.31, m.revenue
  end

  def test_we_can_find_total_revenue_on_a_given_date
    date = Date.parse("2012-03-10")
    m = Merchant.new(data)
    assert_equal 5274.88, m.revenue(date)
  end

  def test_we_can_find_customers_with_unpaid_invoices
    m = Merchant.new(data)
    assert_equal 3, m.customers_with_pending_invoices.count
  end

  def test_it_can_find_customer_with_most_successful_transactions
    m = Merchant.new(data)
    assert_equal "Joey", m.favorite_customer.first_name
  end

end
