require_relative 'repository'

class MerchantRepository < Repository
  def self.most_revenue(limit)
    all.sort_by { |merchant| -merchant.revenue }.first(limit)
  end

  def self.revenue(date)
    all.inject(0) { |sum, x| sum + x.revenue(date) }
  end
end
