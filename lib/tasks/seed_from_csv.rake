require 'csv'

namespace :seed_from_csv do
  desc "Rebuild development db"
  task rebuild: :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
  end

  desc "Seed customers"
  task customers: :environment do
    file = "db/csvs/customers.csv"
    customers_csv = CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)

    customers_csv.each do |row|
      row[:id] = row[:id].to_i
      Customer.create!(row)
    end
    puts("Customers imported")
  end

  desc "Seed merchants"
  task merchants: :environment do
    file = "db/csvs/merchants.csv"
    merchants_csv = CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)

    merchants_csv.each do |row|
      row[:id] = row[:id].to_i
      Merchant.create!(row)
    end
    puts("Merchants imported")
  end

  desc "Seed items"
  task items: :environment do
    file = "db/csvs/items.csv"
    items_csv = CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)

    items_csv.each do |row|
      row[:id] = row[:id].to_i
      row[:unit_price] = (row[:unit_price].to_f / 100).round(2)
      row[:merchant_id] = row[:merchant_id].to_i
      Item.create!(row)
    end
    puts("Items imported")
  end

  desc "Seed invoices"
  task invoices: :environment do
    file = "db/csvs/invoices.csv"
    invoices_csv = CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)

    invoices_csv.each do |row|
      row[:id] = row[:id].to_i
      row[:customer_id] = row[:customer_id].to_i
      row[:merchant_id] = row[:merchant_id].to_i
      Invoice.create!(row)
    end
    puts("Invoices imported")
  end


  desc "Seed invoice_items"
  task invoice_items: :environment do
    file = "db/csvs/invoice_items.csv"
    invoice_items_csv = CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)

    invoice_items_csv.each do |row|
      row[:id] = row[:id].to_i
      row[:item_id] = row[:item_id].to_i
      row[:invoice_id] = row[:invoice_id].to_i
      row[:quantity] = row[:quantity].to_i
      row[:unit_price] = (row[:unit_price].to_f / 100).round(2)
      InvoiceItem.create!(row)
    end
    puts("Invoice Items imported")
  end

  desc "Seed transactions"
  task transactions: :environment do
    file = "db/csvs/transactions.csv"
    transactions_csv = CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)

    transactions_csv.each do |row|
      row[:id] = row[:id].to_i
      row[:invoice_id] = row[:invoice_id].to_i
      Payment.create!(row)
    end
    puts("Transactions imported")
  end

  task :all => [:rebuild, :merchants, :customers, :items, :invoices, :invoice_items, :transactions ]
end
