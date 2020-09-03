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
