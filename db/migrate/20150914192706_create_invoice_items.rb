class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.string :quantity
      t.string :unit_price

      t.timestamps null: false
    end
  end
end
