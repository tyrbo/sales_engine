require_relative 'repository'

class ItemRepository < Repository

  def self.most_revenue(limit)
    all.sort_by do |item|
      item.invoice_items.select(&:successful?)
                        .reduce(0) { |s, x| s + (x.unit_price * x.quantity) }
    end.last(limit).reverse
  end

  def self.most_items(limit)
    all.sort_by do |item|
      item.invoice_items.select(&:successful?)
                        .reduce(0) { |sum, x| sum + x.quantity }
    end.last(limit).reverse
  end

end
