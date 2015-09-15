class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  # def self.invoice_item
  #   invoice_item.to_i
  # end
  #
  # def self.unit_price
  #   unit_price.to_i / 100
  # end

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
