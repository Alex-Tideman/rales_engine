class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

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

  def self.transactions
    self.joins(:invoices)
  end
end
