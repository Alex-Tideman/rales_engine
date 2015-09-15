class Invoice < ActiveRecord::Base
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer

  def self.find(params)
    if params[:status]
      self.find_by_status(params[:status])
    elsif params[:merchant_id]
      self.find_by_merchant_id(params[:merchant_id])
    elsif params[:customer_id]
      self.find_by_customer_id(params[:customer_id])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:status]
      self.where(status: params[:status])
    elsif params[:merchant_id]
      self.where(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      self.where(customer_id: params[:customer_id])
    else
      "Record not found."
    end
  end
end
