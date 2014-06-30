require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test
  def test_can_create_a_customer
    data = { id: 1, first_name: 'John', last_name: 'Smith', created_at: Time.now.to_s, updated_at: Time.now.to_s }
    c = Customer.new(data)

    assert_equal 1, c.id
    assert_equal 'John', c.first_name
    assert_equal 'Smith', c.last_name
    assert c.created_at
    assert c.updated_at
  end
end
