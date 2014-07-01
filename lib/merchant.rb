class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def items
    ItemRepository.find_all_by_merchant_id(id)
  end

  def invoices
    InvoiceRepository.find_all_by_merchant_id(id)
  end
end
