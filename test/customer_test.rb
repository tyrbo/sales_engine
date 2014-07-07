require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/transaction'

class CustomerTest < MiniTest::Test
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
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    data = { id: '1', first_name: "Joey", last_name: "Ondricka", created_at: Time.now.to_s, updated_at: Time.now.to_s }
    invoice = Customer.new(data).invoices

    invoice_1, invoice_2 = invoice

    assert_equal 8, invoice.count
    assert_equal 1, invoice_2.merchant_id
  end

  def test_can_retrieve_transactions
    TransactionRepository.load('test/fixtures/transactions.csv', Transaction)
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)

    transactions = Customer.new(data).transactions
    assert_equal 8, transactions.count
    assert transactions.all? { |x| x.result == 'success' }
  end
end
