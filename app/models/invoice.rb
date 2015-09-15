class Invoice < ActiveRecord::Base
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer

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

  def self.successful
    self.joins(:transactions).where(transactions: { result: "success" })
  end

end
