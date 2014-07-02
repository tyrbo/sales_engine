require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/invoice_item'

class ItemTest < MiniTest::Test
  def data
    { id: '1', name: 'Item TV', description: 'cool', unit_price: '10000', merchant_id: '1', created_at: Time.now.to_s, updated_at: Time.now.to_s }
  end

  def test_can_create_an_item
    i = Item.new(data)

    assert_equal '1', i.id
    assert_equal '1', i.merchant_id
    assert_equal 'Item TV', i.name
    assert_equal 'cool', i.description
    assert_equal '10000', i.unit_price
    assert i.created_at
    assert i.updated_at
  end  

  def test_can_find_merchant_for_item
    MerchantRepository.load('test/fixtures/merchants.csv', Merchant)
    merchant = Item.new(data).merchant
    assert_equal '1', merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
  end

  def test_can_find_invoice_items_for_item
    InvoiceItemRepository.load('test/fixtures/invoice_items.csv', InvoiceItem)
    invoice_item1, invoice_item2 = Item.new(data).invoice_items
    assert_equal '1', invoice_item1.id
    assert_equal '1', invoice_item1.invoice_id
    assert_equal '5', invoice_item1.quantity
    assert_equal '13635', invoice_item1.unit_price

    assert_equal '9', invoice_item2.id
    assert_equal '2', invoice_item2.invoice_id
    assert_equal '6', invoice_item2.quantity
    assert_equal '29973', invoice_item2.unit_price
  end
end
