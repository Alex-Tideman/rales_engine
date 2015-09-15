class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

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
end

