class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.transactions
    self.joins(:invoices)
  end

  def favorite_merchant
    Merchant.find_by(id: invoices.successful_transactions.group(:merchant_id).order('count_id DESC').limit(4).count(:id).keys)
  end

end
