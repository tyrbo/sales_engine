require_relative 'test_helper'

class CSVLoaderTest < Minitest::Test
  def test_it_should_return_rows
    loader = CSVLoader.new('./test/fixtures/customers.csv')
    assert_equal 10, loader.rows.count
  end

  def test_it_should_return_attributes
    loader = CSVLoader.new('./test/fixtures/customers.csv')
    assert_equal 5, loader.attributes.count
    assert_equal :id, loader.attributes.first
  end
end
