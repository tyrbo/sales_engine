require_relative 'test_helper'
require_relative '../lib/repository'
require_relative '../lib/customer'

class RepositoryTest < MiniTest::Test
  def setup
    Repository.load('test/fixtures/customers.csv', Customer)
  end

  def test_it_can_load_data
    assert_equal 10, Repository.all.count
    assert_kind_of Customer, Repository.all.sample
  end

  def test_all_returns_all_entries
    assert_equal 10, Repository.all.count
  end

  def test_random_returns_a_random_entry
    customer1 = Repository.random
    Repository.all.delete(customer1)
    customer2 = Repository.random
    refute_equal customer1, customer2
  end

  def test_find_by_id_finds_an_entry_with_matching_id
    customer = Repository.find_by_id(5)
    assert_equal '5', customer.id
    assert_equal 'Sylvester', customer.first_name
    assert_equal 'Nader', customer.last_name
  end

  def test_find_by_created_at_finds_an_entry_with_matching_date
    customer = Repository.find_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal '1', customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
  end
  
  def test_find_by_updated_at_finds_an_entry_with_matching_date
    customer = Repository.find_by_updated_at('2012-03-27 14:54:10 UTC')
    assert_equal '2', customer.id
    assert_equal 'Cecelia', customer.first_name
    assert_equal 'Osinski', customer.last_name
  end

  def test_find_all_by_last_name
    customers = Repository.find_all_by_last_name('Reynolds')
    assert_equal 2, customers.count
  end

  def test_find_by_attribute_and_value
    customer = Repository.find('id', 5)
    assert_equal '5', customer.id
    assert_equal 'Sylvester', customer.first_name
    assert_equal 'Nader', customer.last_name
  end

  def test_find_all_by_attribute_and_value
    customers = Repository.find_all('last_name', 'Reynolds')
    assert_equal 2, customers.count
  end

  def test_finding_a_missing_field_raises_an_error
    assert_raises(NoMethodError) { Repository.find_by_doesnt_exist }
  end
end
