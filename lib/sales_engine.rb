require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'repository_accessors'
require_relative 'item'
require_relative 'customer'
require_relative 'invoice_item'
require_relative 'merchant'
require_relative 'transaction'
require_relative 'invoice'

class SalesEngine

  attr_reader :merchant_repository, :item_repository

  include RepositoryAccessors

  def initialize(dir)
  end

  def startup
    merchant_repository.load('data/merchants.csv', Merchant)
    item_repository.load('data/items.csv', Item)
    customer_repository.load('data/customers.csv', Customer)
    invoice_repository.load('data/invoices.csv', Invoice)
    invoice_item_repository.load('data/invoice_items.csv', InvoiceItem)
    transaction_repository.load('data/transactions.csv', Transaction)
  end


end
