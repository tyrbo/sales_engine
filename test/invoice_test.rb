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

  # def test_can_create_a_merchant
  #   data = { id: 1, name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
  #   m = Merchant.new(data)
  #
  #   assert_equal 1, m.id
  #   assert_equal 'Best Buy', m.name
  #   assert m.created_at
  #   assert m.updated_at
  # end
  #
  # def test_we_can_find_items_belonging_to_merchant
  #   ItemRepository.load('test/fixtures/items.csv', Item)
  #   data = { id: 1, name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
  #   items = Merchant.new(data).items
  #   assert_equal 2, items.count
  #
  #   item1, item2 = items
  #   assert_equal 'Item Qui Esse', item1.name
  #   assert_equal 'Item Autem Minima', item2.name
  # end
  #
  # def test_invoices
  #   skip
  # end

end
