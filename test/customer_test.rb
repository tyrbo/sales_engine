require_relative 'test_helper'

class CustomerTest < MiniTest::Test
  include RepositoryAccessors

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
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)
    data = { id: '1', first_name: "Joey", last_name: "Ondricka", created_at: Time.now.to_s, updated_at: Time.now.to_s }
    invoice = Customer.new(data).invoices

    invoice_1, invoice_2 = invoice

    assert_equal 9, invoice.count
    assert_equal 1, invoice_2.merchant_id
  end

  def test_can_retrieve_transactions
    transaction_repository.load('test/fixtures/transactions.csv', Transaction)
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)

    transactions = Customer.new(data).transactions
    assert_equal 8, transactions.count
    assert transactions.all? { |x| x.result == 'success' }
  end

  def test_can_find_favorite_merchant
    transaction_repository.load('test/fixtures/transactions.csv', Transaction)
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)
    merchant_repository.load('test/fixtures/merchants.csv', Merchant)

    merchant = Customer.new(data).favorite_merchant
    assert_equal 'Schroeder-Jerde', merchant.name
  end
end
