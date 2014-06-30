require_relative 'test_helper'
require_relative '../lib/repository'
require_relative '../lib/customer'

class RepositoryTest < MiniTest::Test
  def test_it_can_load_data
    r = Repository.new
    r.load('test/fixtures/customers.csv')

    assert_equal 10, r.entries.count
    assert_kind_of Customer, r.entries.first
  end
end
