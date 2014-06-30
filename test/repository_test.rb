require_relative 'test_helper'
require_relative '../lib/repository'
require_relative '../lib/customer'

class RepositoryTest < MiniTest::Test
  attr_reader :repo

  def setup
    @repo = Repository.new(Customer)
  end

  def test_it_can_receive_a_type
    assert_equal Customer, repo.type
  end

  def test_it_can_load_data
    repo.load('test/fixtures/customers.csv')
    assert_equal 10, repo.entries.count
    assert_kind_of Customer, repo.entries.sample
  end

  def test_all_returns_all_entries
    repo.load('test/fixtures/customers.csv')
    assert_equal 10, repo.all.count
  end

  def test_random_returns_a_random_entry
    repo.load('test/fixtures/customers.csv')
    customer1 = repo.random
    repo.entries.delete(customer1)
    customer2 = repo.random
    refute_equal customer1, customer2
  end

  def test_find_by_id_finds_an_entry_with_matching_id
    repo.load('test/fixtures/customers.csv')
    customer = repo.find_by_id(5)
    assert_equal '5', customer.id
    assert_equal 'Sylvester', customer.first_name
    assert_equal 'Nader', customer.last_name
  end

  def test_find_by_created_at_finds_an_entry_with_matching_date
    repo.load('test/fixtures/customers.csv')
    customer = repo.find_by_created_at('2012-03-27 14:54:09 UTC')
    assert_equal '1', customer.id
    assert_equal 'Joey', customer.first_name
    assert_equal 'Ondricka', customer.last_name
  end
  
  def test_find_by_updated_at_finds_an_entry_with_matching_date
    repo.load('test/fixtures/customers.csv')
    customer = repo.find_by_updated_at('2012-03-27 14:54:10 UTC')
    assert_equal '2', customer.id
    assert_equal 'Cecelia', customer.first_name
    assert_equal 'Osinski', customer.last_name
  end

  def test_find_by_attribute_and_value
    repo.load('test/fixtures/customers.csv')
    customer = repo.find('id', 5)
    assert_equal '5', customer.id
    assert_equal 'Sylvester', customer.first_name
    assert_equal 'Nader', customer.last_name
  end

  def test_find_all_by_attribute_and_value
    repo.load('test/fixtures/customers.csv')
    customers = repo.find_all('last_name', 'Reynolds')
    assert_equal 2, customers.count
  end

  def test_finding_a_missing_field_raises_an_error
    assert_raises(NoMethodError) { repo.find_by_doesnt_exist }
  end
end
