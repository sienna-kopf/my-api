class RevenueFacade
  def self.merchant_revenue(merchant)
    result = merchant.invoices.joins(:invoice_items).joins(:payments).select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue").where("payments.result = 'success' AND status = 'shipped'").group(:id).order("revenue desc").first.revenue

    Revenue.new(result)
  end
end
