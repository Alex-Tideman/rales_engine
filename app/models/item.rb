class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

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
    self.all.sort_by { |item| item.revenue }.reverse[0..quantity]
  end

  def self.most_items(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |item| item.item_count }.reverse[0..quantity]
  end

  def revenue
      invoices.successful.joins(:invoice_items).sum('quantity * unit_price')
  end

  def item_count
    invoices.successful.joins(:invoice_items).sum('quantity')
  end

end

