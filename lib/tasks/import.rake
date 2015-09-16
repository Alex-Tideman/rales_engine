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
    InvoiceItem.create!({:id          => row[:id],
                          :quantity    => row[:quantity],
                          :unit_price  => row[:unit_price].to_f / 100,
                          :item_id     => row[:item_id],
                          :invoice_id  => row[:invoice_id],
                          :created_at  => row[:created_at],
                          :updated_at  => row[:updated_at]
                 })
  end

  CSV.foreach(file3, headers: true, header_converters: :symbol) do |row|
    Invoice.create!(row.to_hash)
  end

  CSV.foreach(file4, headers: true, header_converters: :symbol) do |row|
    Item.create!({:id          => row[:id],
                  :name        => row[:name],
                  :description => row[:description],
                  :unit_price  => row[:unit_price].to_f / 100,
                  :merchant_id => row[:merchant_id],
                  :created_at  => row[:created_at],
                  :updated_at  => row[:updated_at]
                 })
  end

  CSV.foreach(file5, headers: true, header_converters: :symbol) do |row|
    Merchant.create!(row.to_hash)
  end

  CSV.foreach(file6, headers: true, header_converters: :symbol) do |row|
    Transaction.create!(row.to_hash)
  end

end
