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
    #total_price = 0

    #invoices.each do |invoice|
    #  transactions = invoice.transactions.select { |transaction| transaction.result == 'success' }
    #  transactions.each do |transaction|
    #    invoice_items = invoice_item_repository.find_all_by_invoice_id(transaction.invoice_id)
    #    invoice_items.each do |invoice_item|
    #      total_price += invoice_item.unit_price.to_f * invoice_item.quantity.to_i
    #    end
    #  end
    #end

    #total_price

    arr = invoices.collect do |invoice|
      invoice.transactions.select { |transaction| transaction.result == 'success' }.collect do |transaction|
        invoice_item_repository.find_all_by_invoice_id(transaction.invoice_id).map do |invoice_item|
          invoice_item.unit_price.to_f * invoice_item.quantity.to_i
        end
      end
    end
    arr.flatten.uniq.inject(0, :+)
  end
end
