module RepositoryAccessors
  def merchant_repository
    MerchantRepository
  end

  def invoice_repository
    InvoiceRepository
  end

  def item_repository
    ItemRepository
  end

  def invoice_item_repository
    InvoiceItemRepository
  end

  def customer_repository
    CustomerRepository
  end

  def transaction_repository
    TransactionRepository
  end
end
