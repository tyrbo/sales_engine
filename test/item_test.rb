require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

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
end
