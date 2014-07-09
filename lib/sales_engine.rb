require_relative 'repository_accessors'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'item'
require_relative 'customer'
require_relative 'invoice_item'
require_relative 'merchant'
require_relative 'transaction'
require_relative 'invoice'
require_relative 'csv_loader'

class SalesEngine
  include RepositoryAccessors

  def initialize(csv_dir)
    @csv_dir = csv_dir
  end

  def startup
    merchant_repository.load     CSVLoader.new('data/merchants.csv'), Merchant
    item_repository.load         CSVLoader.new('data/items.csv'), Item
    customer_repository.load     CSVLoader.new('data/customers.csv'), Customer
    invoice_repository.load      CSVLoader.new('data/invoices.csv'), Invoice
    invoice_item_repository.load CSVLoader.new('data/invoice_items.csv'), InvoiceItem
    transaction_repository.load  CSVLoader.new('data/transactions.csv'), Transaction
  end
end
