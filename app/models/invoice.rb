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

  def self.successful
    self.includes(:transactions).where(transactions: { result: "success" })
  end

  def self.pending
    self.all - successful
  end

  def self.successful_transactions
    self.joins(:transactions).where(transactions: { result: "success" })
  end

  def top_merchant
    self.all.group(:id).count
  end

end
