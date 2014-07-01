require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class MerchantTest < MiniTest::Test
  def data
    { id: 1, name: 'Best Buy', created_at: Time.now.to_s, updated_at: Time.now.to_s }
  end

  def test_can_create_a_merchant
    m = Merchant.new(data)

    assert_equal 1, m.id
    assert_equal 'Best Buy', m.name
    assert m.created_at
    assert m.updated_at
  end

  def test_we_can_find_items_belonging_to_merchant
    ItemRepository.load('test/fixtures/items.csv', Item)
    items = Merchant.new(data).items
    assert_equal 2, items.count

    item1, item2 = items
    assert_equal 'Item Qui Esse', item1.name
    assert_equal 'Item Autem Minima', item2.name
  end

  def test_invoices
    skip
  end

end
