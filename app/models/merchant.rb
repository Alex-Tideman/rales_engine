class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.find(params)
    if params[:name]
      self.find_by_name(params[:name])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:name]
      self.where(name: params[:name])
    else
      "Record not found."
    end
  end

  def self.most_revenue(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.revenue }.reverse[0..quantity]
  end

  def self.most_items(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.item_count }.reverse[0..quantity]
  end

  def revenue
    invoices.successful.includes(:invoice_items).sum('quantity * unit_price')
  end

  def item_count
    invoices.successful.includes(:invoice_items).sum('quantity')
  end

end
