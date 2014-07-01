require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test
  def data
    { id: '1', item_id: '1', invoice_id: '1', quantity: '6', unit_price: '1000', created_at: Time.now, updated_at: Time.now }
  end

  def test_can_create_an_invoice_item
    i = InvoiceItem.new(data)
    assert_equal '1', i.id
    assert_equal '1', i.item_id
    assert_equal '1', i.invoice_id
    assert_equal '6', i.quantity
    assert_equal '1000', i.unit_price
    assert i.created_at
    assert i.updated_at
  end  
end
