require_relative 'test_helper'

class MerchantRepositoryTest < MiniTest::Test
  include RepositoryAccessors
  
  def setup
    merchant_repository.load(CSVLoader.new('test/fixtures/merchants.csv'), Merchant)
    invoice_repository.load(CSVLoader.new('test/fixtures/invoices.csv'), Invoice)
    transaction_repository.load(CSVLoader.new('test/fixtures/transactions.csv'), Transaction)
    invoice_item_repository.load(CSVLoader.new('test/fixtures/invoice_items.csv'), InvoiceItem)
  end

  def test_most_revenue_returns_top_instances

    merchants = merchant_repository.most_revenue(5)
    assert_equal 5, merchants.count

    first, second = merchants

    assert_equal 'Schroeder-Jerde', first.name
    assert_equal 'Klein, Rempel and Jones', second.name
  end

  def test_returns_top_merchant_ranked_by_total_number_of_items_sold
    assert_equal "Schroeder-Jerde", merchant_repository.most_items(1).first.name
  end

  def test_revenue_by_date_returns_revenue_for_date
    date = Date.parse("2012-03-10")
    assert_equal 5274.88, merchant_repository.revenue(date)
  end
end
  
