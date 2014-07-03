require_relative 'repository'

class MerchantRepository < Repository
  def self.most_revenue(limit)
    all.sort_by { |merchant| -merchant.revenue }.first(limit)
  end
end
