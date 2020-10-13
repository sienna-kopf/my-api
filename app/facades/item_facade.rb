class ItemFacade
  def self.merchants_by_items(quantity)
    Merchant.joins(invoices: [:invoice_items, :payments])
      .select("merchants.*, sum(invoice_items.quantity) as items_sold")
      .where("payments.result='success' AND invoices.status='shipped'")
      .group(:id)
      .order("items_sold desc")
      .limit(quantity)
  end
end
