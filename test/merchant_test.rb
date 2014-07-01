require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/item'

class MerchantTest < MiniTest::Test
  def test_can_create_a_merchant
    data = { id: 1, name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
    m = Merchant.new(data)

    assert_equal 1, m.id
    assert_equal 'Best Buy', m.name
    assert m.created_at
    assert m.updated_at
  end

  def test_we_can_find_items_belonging_to_merchant
    ItemRepository.load('test/fixtures/items.csv', Item)
    data = { id: 1, name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
    items = Merchant.new(data).items
    assert_equal 2, items.count

    item1, item2 = items
    assert_equal 'Item Qui Esse', item1.name
    assert_equal 'Item Autem Minima', item2.name
  end

  def test_we_can_find_invoices_belonging_to_merchant
    InvoiceRepository.load('test/fixtures/invoices.csv', Invoice)
    data = { id: 1, name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
    invoices = Merchant.new(data).invoices

    invoice1, invoice2 = invoices

    assert_equal 3, invoices.count
    assert_equal 'shipped', invoice1.status
    assert_equal "2", invoice2.id
  end

  

end
