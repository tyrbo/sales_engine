require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < MiniTest::Test

  def test_can_create_an_item
  data = { id: '1', name: 'Item TV', description: 'cool', unit_price: '10000', merchant_id: '1', created_at: Time.now.to_s, updated_at: Time.now.to_s }
    i = Item.new(data)

    assert_equal '1', i.id
    assert_equal '1', i.merchant_id
    assert_equal 'Item TV', i.name
    assert_equal 'cool', i.description
    assert_equal '10000', i.unit_price
    assert i.created_at
    assert i.updated_at
  end

  
end
