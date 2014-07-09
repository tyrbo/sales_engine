require_relative 'repository'

class ItemRepository < Repository

  def self.most_revenue(limit)
    all.sort_by do |item|
      item.invoice_items.find_all(&:successful?)
                        .reduce(0) { |sum, x| sum + (x.unit_price * x.quantity) }
    end.last(limit).reverse
  end

  def self.most_items(limit)
    all.sort_by do |item|
      item.invoice_items.find_all(&:successful?)
                        .reduce(0) { |sum, x| sum + x.quantity }
    end.last(limit).reverse
    # >>top x num of items by total number sold
    # find successful transactions
    # group them by item id
    # sort by quantity
    # return name
  end

end
