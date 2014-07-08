require_relative 'repository'

class MerchantRepository < Repository
  def self.most_revenue(limit)
    all.sort_by { |merchant| merchant.revenue }.reverse.first(limit)
  end

  def self.most_items(limit)
    all.sort_by do |merchant|
        merchant.invoices.select(&:successful?)
                         .flat_map(&:invoice_items)
                         .inject(0) { |sum, i| sum + i.quantity }
    end.reverse.first(limit)
  end
end
