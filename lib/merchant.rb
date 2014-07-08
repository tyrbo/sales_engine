require_relative 'repository_accessors'

class Merchant
  include RepositoryAccessors

  attr_reader :id, :name, :created_at, :updated_at

  def initialize(data)
    @id         = data[:id].to_i
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

  def revenue(date=nil)
    if date
      invoices_for_date = invoices.select { |i| Date.parse(i.created_at) == date }
      calculate_revenue(invoices_for_date)
    else
      calculate_revenue(invoices)
    end
  end

  def customers_with_pending_invoices
    invoices.reject(&:successful?).map do |invoice|
      invoice.customer
    end
  end

  def favorite_customer
    invoices.select(&:successful?)
            .group_by(&:customer_id)
            .max_by { |_, v| v.count }[-1][0]
            .customer
            .first_name
  end

  private

  def calculate_revenue(invoices)
    arr = invoices.flat_map do |invoice|
      next 0 if invoice.transactions.none?(&:successful?)
      invoice.invoice_items.map(&:total)
    end
    arr.inject(0, :+)
  end
end
