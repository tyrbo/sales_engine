require_relative 'repository_accessors'

class Merchant
  include RepositoryAccessors

  attr_reader :id, :name, :created_at, :updated_at

  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def items
    item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    invoice_repository.find_all_by_merchant_id(id)
  end

  def revenue
    arr = invoices.flat_map do |invoice|
      invoice.transactions.select { |transaction| transaction.result == 'success' }.flat_map do |transaction|
        invoice_item_repository.find_all_by_invoice_id(transaction.invoice_id).map do |invoice_item|
          invoice_item.unit_price.to_f * invoice_item.quantity.to_i
        end
      end
    end
    arr.uniq.inject(0, :+)
  end
end
