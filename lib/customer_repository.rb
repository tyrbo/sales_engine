require_relative 'repository'

class CustomerRepository < Repository

  def self.most_items
    all.max_by do |customer|
      customer.invoices.select(&:successful?)
                       .flat_map(&:invoice_items)
                       .inject(0) { |sum, x| sum + x.quantity }
    end
  end

  def self.most_revenue
    all.max_by do |customer|
      customer.invoices.select(&:successful?)
                       .flat_map(&:invoice_items)
                       .inject(0) { |sum, x| sum + (x.quantity * x.unit_price) }
    end
  end
end
