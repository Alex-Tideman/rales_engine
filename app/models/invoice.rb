class Invoice < ActiveRecord::Base
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer

  def self.successful
    self.includes(:transactions).where(transactions: { result: "success" })
  end

  def self.pending
    self.includes(:transactions).where(transactions: { result: "failed" })
  end

  def self.successful_transactions
    self.joins(:transactions).where(transactions: { result: "success" })
  end

end
