require 'csv'

desc "Imports Sales Engine CSV file into an ActiveRecord table"
task :import => :environment do

  file1 = 'db/customers.csv'
  file2 = 'db/invoice_items.csv'
  file3 = 'db/invoices.csv'
  file4 = 'db/items.csv'
  file5 = 'db/merchants.csv'
  file6 = 'db/transactions.csv'

  CSV.foreach(file1, headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_hash)
  end

  CSV.foreach(file2, headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create!(row.to_hash)
  end

  CSV.foreach(file3, headers: true, header_converters: :symbol) do |row|
    Invoice.create!(row.to_hash)
  end

  CSV.foreach(file4, headers: true, header_converters: :symbol) do |row|
    Item.create!(row.to_hash)
  end

  CSV.foreach(file5, headers: true, header_converters: :symbol) do |row|
    Merchant.create!(row.to_hash)
  end

  CSV.foreach(file6, headers: true, header_converters: :symbol) do |row|
    Transaction.create!(row.to_hash)
  end

end
