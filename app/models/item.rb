class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |item| item.revenue }.reverse[0..quantity]
  end

  def self.most_items(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |item| item.item_count }.reverse[0..quantity]
  end

  def revenue
      invoice_items.invoices.successful.joins(:invoice_items).sum('quantity * unit_price')
  end

  def item_count
    invoices.successful.joins(:invoice_items).sum('quantity')
  end

end

