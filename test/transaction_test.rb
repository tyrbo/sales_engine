require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/invoice'

class TransactionTest < Minitest::Test

  def data
    data = {
            id: '1',
            invoice_id: '1',
            credit_card_number: '0000000000000001',
            credit_card_expiration_date: '',
            result: "success",
            created_at: Time.now.to_s,
            updated_at: Time.now.to_s
            }
  end

  def test_can_retrieve_transactions
    t = Transaction.new(data)

    assert_equal 1, t.id
    assert_equal 1, t.invoice_id
    assert_equal '0000000000000001', t.credit_card_number
    # refute t.credit_card_expiration_date
    assert_equal 'success', t.result
    assert       t.created_at
    assert       t.updated_at
  end

  def test_can_find_associated_invoices
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    invoice = Transaction.new(data).invoice

    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 1, invoice.merchant_id
    assert_equal 'shipped', invoice.status
  end
end
