require_relative 'test_helper'
require_relative '../lib/invoice'


class InvoiceTest < MiniTest::Test

  def test_can_create_an_invoice
    data = { id: 1, customer_id: 1, merchant_id: 1, status: 'shipped', created_at: Time.now.to_s, updated_at: Time.now.to_s }
    i = Invoice.new(data)

    assert_equal 1, i.id
    assert_equal 1, i.customer_id
    assert_equal 1, i.merchant_id
    assert_equal 'shipped', i.status
    assert i.created_at
    assert i.updated_at
  end

end
