class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.most_revenue(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.revenue }.reverse[0..quantity]
  end

  def self.most_items(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.item_count }.reverse[0..quantity]
  end

  def self.total_revenue(date)
    sum = self.all.map { |merchant| merchant.revenue(date) }.reduce(:+)
    {:total_revenue => sum.round(2) }
  end

  def single_revenue(date)
    sum = self.revenue(date)
    {:revenue => sum.round(2) }
  end

  def revenue(date = nil)
    if date.nil?
      invoices.successful.joins(:invoice_items).sum('quantity * unit_price')
    else
      invoices.successful.where(invoices: { created_at: date }).joins(:invoice_items).sum('quantity * unit_price')
    end
  end

  def item_count
    invoices.successful.joins(:invoice_items).sum('quantity')
  end

  def favorite_customer
    Customer.find_by(id: invoices.successful.group(:customer_id).count
                             .sort_by {|pair| [pair.last, pair.first]}.reverse.first.first)
  end

  def customers_with_pending_invoices
    Invoice.pending.map do |invoice|
      invoice.customer if invoice.merchant_id == self.id
    end.compact
  end


end
