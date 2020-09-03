require 'rails_helper'

RSpec.describe "Revenue Facade" do
  describe "class methods" do
    describe ".merchant_revenue" do
      it "returns the total revenue for a single merchant" do
        merchant = create(:merchant)
        customer = create(:customer)
        invoice = create(:invoice, merchant: merchant)
        payment = create(:payment, invoice: invoice)

        item_1 = create(:item, merchant: merchant)
        item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.50, merchant: merchant)
        item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant)

        create(:invoice_item, invoice: invoice, item: item_1)
        InvoiceItem.create!(quantity: 1, unit_price: 45.50, item_id: item_2.id, invoice_id: invoice.id)
        InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice.id)

        result = RevenueFacade.merchant_revenue(merchant)

        expect(result).to be_a Revenue
        expect(result.revenue).to eq(80.5)
      end
    end
    describe ".date_range_revenue" do
      it "returns the total revenue for all merchants across a date range" do
        merchant_1 = create(:merchant)
        merchant_2 = Merchant.create!(name: "Stuffed Animal Shop")
        merchant_3 = Merchant.create!(name: "Barn O' Stuff")

        customer = create(:customer)
        invoice_1 = create(:invoice, merchant: merchant_1)
        invoice_2 = create(:invoice, merchant: merchant_2)
        invoice_3 = create(:invoice, merchant: merchant_3)
        payment = create(:payment, invoice: invoice_1, updated_at: "2012-03-25 10:22:00")
        payment = create(:payment, invoice: invoice_2, updated_at: "2012-03-25 18:45:00")
        payment = create(:payment, invoice: invoice_3, updated_at: "2012-03-26 09:05:00")

        item_1 = create(:item, merchant: merchant_2)
        item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.00, merchant: merchant_1)
        item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant_2)
        item_4 = Item.create!(name: "Saddle", description: "Ride a horse with it", unit_price: 100.00, merchant: merchant_3)
        item_5 = Item.create!(name: "Spurs", description: "Cow boot spikes", unit_price: 20.50, merchant: merchant_3)
        item_6 = Item.create!(name: "Space Dino Beanie Baby", description: "Galexy dinosaur", unit_price: 4.50, merchant: merchant_2)

        create(:invoice_item, invoice: invoice_2, item: item_1)
        InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice_2.id)
        InvoiceItem.create!(quantity: 1, unit_price: 100.00, item_id: item_4.id, invoice_id: invoice_3.id)
        InvoiceItem.create!(quantity: 2, unit_price: 45.00, item_id: item_2.id, invoice_id: invoice_1.id)
        InvoiceItem.create!(quantity: 3, unit_price: 20.50, item_id: item_5.id, invoice_id: invoice_3.id)
        InvoiceItem.create!(quantity: 4, unit_price: 4.50, item_id: item_6.id, invoice_id: invoice_2.id)

        start_date = "2012-03-25"
        end_date = "2012-03-25"
        result = RevenueFacade.date_range_revenue(start_date, end_date)

        expect(result).to be_a Revenue
        expect(result.revenue).to eq(143.0)
      end
    end
    describe ".merchants_by_revenue" do
      it "returns list of merchants by total revenue" do
        merchant_1 = create(:merchant)
        merchant_2 = Merchant.create!(name: "Stuffed Animal Shop")
        merchant_3 = Merchant.create!(name: "Barn O' Stuff")

        customer = create(:customer)
        invoice_1 = create(:invoice, merchant: merchant_1)
        invoice_2 = create(:invoice, merchant: merchant_2)
        invoice_3 = create(:invoice, merchant: merchant_3)
        payment = create(:payment, invoice: invoice_1)
        payment = create(:payment, invoice: invoice_2)
        payment = create(:payment, invoice: invoice_3)

        item_1 = create(:item, merchant: merchant_2)
        item_2 = Item.create!(name: "Quickdraws", description: "Technical safety eq.", unit_price: 45.00, merchant: merchant_1)
        item_3 = Item.create!(name: "Drawsaurus Stuffed Animal", description: "Based off the hit pictionary game", unit_price: 5.00, merchant: merchant_2)
        item_4 = Item.create!(name: "Saddle", description: "Ride a horse with it", unit_price: 100.00, merchant: merchant_3)

        create(:invoice_item, invoice: invoice_2, item: item_1)
        InvoiceItem.create!(quantity: 5, unit_price: 5.00, item_id: item_3.id, invoice_id: invoice_2.id)
        InvoiceItem.create!(quantity: 1, unit_price: 100.00, item_id: item_4.id, invoice_id: invoice_3.id)
        InvoiceItem.create!(quantity: 2, unit_price: 45.00, item_id: item_2.id, invoice_id: invoice_1.id)

        quantity = 2
        result = RevenueFacade.merchants_by_revenue(quantity)

        expect(result[0]).to be_a Merchant
        expect(result[0].name).to eq("Barn O' Stuff")
        expect(result[1].name).to eq("Josh's Dog Shop")
      end
    end
  end
end
