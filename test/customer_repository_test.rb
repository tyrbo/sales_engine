require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  include RepositoryAccessors

  def setup
    customer_repository.load(CSVLoader.new('test/fixtures/customers.csv'), Customer)
    invoice_repository.load(CSVLoader.new('test/fixtures/invoices.csv'), Invoice)
    invoice_item_repository.load(CSVLoader.new('test/fixtures/invoice_items.csv'), InvoiceItem)
    transaction_repository.load(CSVLoader.new('test/fixtures/transactions.csv'), Transaction)
  end

  def test_most_items_returns_customer_with_highest_item_quantity_bought
    customer = customer_repository.most_items
    assert_equal 1, customer.id
  end

  def test_most_revenue_returns_customer_with_highest_revenue
    customer = customer_repository.most_revenue
    assert_equal 1, customer.id
  end

end
