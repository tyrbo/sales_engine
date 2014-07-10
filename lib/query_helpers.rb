module QueryHelpers
  def successful_invoices_grouped(field)
    invoices.select(&:successful?)
            .group_by(&field)
            .max_by { |_, v| v.count }[-1][0]
  end
end
