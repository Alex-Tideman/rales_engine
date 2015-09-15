class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.find(params)
    attribute = params.first.first
    attribute_value = params.first.last

    if params
      if attribute_value.is_a?(Numeric)
        self.where(attribute => attribute_value).first
      else
        self.where("#{attribute} ILIKE ?", attribute_value).first
      end
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    attribute = params.first.first
    attribute_value = params.first.last

    if params
      if attribute_value.is_a?(Numeric)
        self.where(attribute => attribute_value)
      else
        self.where("#{attribute} ILIKE ?", attribute_value)
      end
    else
      "Record not found."
    end
  end

  def self.most_revenue(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.merch_revenue }.reverse[0..quantity]
  end

  def self.most_items(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.item_count }.reverse[0..quantity]
  end

  def self.revenue(date)
    self.all.map { |merchant| merchant.merch_revenue(date) }.reduce(:+)
  end

  def merch_revenue(date = nil)
    if date.nil?
      invoices.successful.includes(:invoice_items).sum('quantity * unit_price')
    else
      invoices.successful.where(invoices: { created_at: date }).includes(:invoice_items).sum('quantity * unit_price')
    end
  end

  def item_count
    invoices.successful.includes(:invoice_items).sum('quantity')
  end

end
