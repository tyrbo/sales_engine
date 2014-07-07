require_relative 'repository_accessors'

class Invoice
  include RepositoryAccessors

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
  end

  def transactions
    transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.collect { |item| item_repository.find_by_id(item.item_id) }
  end

  def customer
    customer_repository.find_by_id(customer_id)
  end

  def merchant
    merchant_repository.find_by_id(merchant_id)
  end
end
