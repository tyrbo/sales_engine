require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
# require_relative '../lib/invoice'

class TransactionTest < Minitest::Test

  def data
    data = {
            id: 1,
            invoice_id: 1,
            credit_card_number: 0000_0000_0000_0001,
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
    assert_equal 0000000000000001, t.credit_card_number
    # refute t.credit_card_expiration_date
    assert_equal 'success', t.result
    assert       t.created_at
    assert       t.updated_at
  end

  def test_can_find_associated_invoices
    TransactionRepository.load('test/fixtures/transactions.csv', Transaction)
    invoice = Transaction.new(data).invoice

    invoice1, invoice2 = invoice

    assert_equal 1, invoice.count
    assert_equal 'success', invoice1.result
    # assert_equal "2", invoice2.id
    assert_equal "4654405418249632", invoice1.credit_card_number
  end


end
