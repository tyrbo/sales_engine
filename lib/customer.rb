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
    invoices.select(&:successful?)
            .group_by(&:merchant_id)
            .max_by { |_, v| v.count }[-1][0]
            .merchant
  end

  def days_since_activity(date = Date.today)
    most_recent_transaction = transactions.select(&:successful?)
                                          .max_by { |x| x.created_at }
                                          .created_at
    (date - Date.parse(most_recent_transaction)).to_i
  end

  def pending_invoices
    invoices.reject(&:successful?)
  end
end
