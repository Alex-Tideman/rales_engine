class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.find(params)
    attribute = params.first.first
    attribute_value = params.first.last

    if params
      self.where("#{attribute} ILIKE ?", attribute_value).first
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    attribute = params.first.first
    attribute_value = params.first.last

    if params
      self.where("#{attribute} ILIKE ?", attribute_value)
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
