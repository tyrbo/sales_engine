require_relative 'test_helper'

class CustomerTest < MiniTest::Test
  include RepositoryAccessors

  def setup
    invoice_repository.load(CSVLoader.new('test/fixtures/invoices.csv'), Invoice)
    transaction_repository.load(CSVLoader.new('test/fixtures/transactions.csv'), Transaction)
    merchant_repository.load(CSVLoader.new('test/fixtures/merchants.csv'), Merchant)
  end

  def data
    data = { id: '1', first_name: 'John', last_name: 'Smith', created_at: Time.now.to_s, updated_at: Time.now.to_s }
  end

  def test_can_create_a_customer
    c = Customer.new(data)

    assert_equal 1, c.id
    assert_equal 'John', c.first_name
    assert_equal 'Smith', c.last_name
    assert c.created_at
    assert c.updated_at
  end

  def test_can_retrieve_invoices
    invoice = Customer.new(data).invoices

    invoice_1, invoice_2 = invoice

    assert_equal 9, invoice.count
    assert_equal 1, invoice_2.merchant_id
  end

  def test_can_retrieve_transactions
    transactions = Customer.new(data).transactions
    assert_equal 8, transactions.count
    assert transactions.all? { |x| x.result == 'success' }
  end

  def test_can_find_favorite_merchant
    merchant = Customer.new(data).favorite_merchant
    assert_equal 'Schroeder-Jerde', merchant.name
  end

  def test_days_since_activity_will_give_days_since_last_transaction
    assert_equal 834, Customer.new(data).days_since_activity(Date.new(2014, 7, 9))
  end

  def test_pending_invoices_returns_invoices_with_no_successful_transactions
    assert_equal 2, Customer.new(data).pending_invoices.count
  end
end
