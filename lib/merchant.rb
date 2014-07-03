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
      next 0 if invoice.transactions.none?(&:successful?)
      invoice.invoice_items.map(&:total)
    end
    arr.inject(0, :+)
  end
end
