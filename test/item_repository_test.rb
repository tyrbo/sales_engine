require_relative 'test_helper'
require_relative '../lib/repository_accessors'
require_relative '../lib/merchant'
require_relative '../lib/invoice'
require_relative '../lib/transaction'
require_relative '../lib/invoice_item'
require_relative '../lib/item'

class ItemRepositoryTest < MiniTest::Test
  include RepositoryAccessors

  def test_most_revenue_returns_top_items_by_total_revenue
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)
    transaction_repository.load('test/fixtures/transactions.csv', Transaction)
    invoice_item_repository.load('test/fixtures/invoice_items.csv', InvoiceItem)
    item_repository.load('test/fixtures/items.csv', Item)

    assert_equal "Item Eius Et", item_repository.most_revenue(1).first.name
  end

  def test_most_items_returns_top_items_by_total_sold
    skip
  end

end
