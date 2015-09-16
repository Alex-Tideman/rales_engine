class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    Merchant.find_by(id: invoices.successful_transactions.group(:merchant_id).order('count_id DESC').limit(1).count(:id).keys)
  end

end
