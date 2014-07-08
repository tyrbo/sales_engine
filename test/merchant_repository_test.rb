require_relative 'test_helper'
require_relative '../lib/repository_accessors'
require_relative '../lib/merchant'
require_relative '../lib/invoice'
require_relative '../lib/transaction'
require_relative '../lib/invoice_item'
require_relative '../lib/item'

class MerchantRepositoryTest < MiniTest::Test
  include RepositoryAccessors

  def test_most_revenue_returns_top_instances
    merchant_repository.load('test/fixtures/merchants.csv', Merchant)
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)
    transaction_repository.load('test/fixtures/transactions.csv', Transaction)
    invoice_item_repository.load('test/fixtures/invoice_items.csv', InvoiceItem)

    merchants = merchant_repository.most_revenue(5)
    assert_equal 5, merchants.count

    first, second = merchants

    assert_equal 'Schroeder-Jerde', first.name
    assert_equal 'Klein, Rempel and Jones', second.name
  end

  def test_returns_top_merchant_ranked_by_total_number_of_items_sold
    merchant_repository.load('test/fixtures/merchants.csv', Merchant)
    invoice_item_repository.load('test/fixtures/invoice_items.csv', InvoiceItem)
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)
    transaction_repository.load('test/fixtures/transactions.csv', Transaction)
    assert_equal "Schroeder-Jerde", merchant_repository.most_items(1).first.name
  end

  def test_revenue_by_date_returns_revenue_for_date
    merchant_repository.load('test/fixtures/merchants.csv', Merchant)
    invoice_repository.load('test/fixtures/invoices.csv', Invoice)
    transaction_repository.load('test/fixtures/transactions.csv', Transaction)
    invoice_item_repository.load('test/fixtures/invoice_items.csv', InvoiceItem)

    date = Date.parse("2012-03-10")
    assert_equal 5274.88, MerchantRepository.revenue(date)
  end
end
