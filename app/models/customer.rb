class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

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

  def self.transactions
    self.joins(:invoices)
  end
end
