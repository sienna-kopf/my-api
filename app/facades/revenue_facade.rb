class RevenueFacade
  def self.merchant_revenue(merchant)
    result = merchant.invoices.joins(:invoice_items).joins(:payments).select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("payments.result = 'success' AND status = 'shipped'").group(:id).order("revenue desc").first.revenue

    Revenue.new(result)
  end

  def self.merchants_by_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :payments]).select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("payments.result='success' AND invoices.status='shipped'").group(:id).order("revenue desc").limit(quantity)
  end

  def self.date_range_revenue(start_date, end_date)
    result = InvoiceItem.joins(invoice: :payments).select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("invoices.status='shipped' AND payments.result='success'").where(payments: {updated_at: Date.parse(start_date).beginning_of_day..Date.parse(end_date).end_of_day})

    revenue = result[0].revenue
    Revenue.new(revenue)
  end
end
