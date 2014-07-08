require_relative 'repository_accessors'

class Customer
  include RepositoryAccessors

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def invoices
    invoice_repository.find_all_by_customer_id(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def favorite_merchant
    transactions.select(&:successful?)
                .collect(&:invoice)
                .group_by(&:merchant_id)
                .max_by { |v| v.count }[-1][0]
                .merchant
  end
end
