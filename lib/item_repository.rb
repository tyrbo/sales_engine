require_relative 'repository'

class ItemRepository < Repository

  def self.most_revenue(limit)
    all.sort_by do |item|
      item.invoice_items.find_all(&:successful?)
                        .reduce(0) { |sum, x| sum + (x.unit_price * x.quantity) }
    end.last(limit)
  end

  def self.most_items(limit)
    most_items = items.invoices.select(&:successful?)
                  .group_by(&:item_id)

                  p most_items
    # >>top x num of items by total number sold
    # find successful transactions
    # group them by item id
    # sort by quantity
    # return name
  end

end
