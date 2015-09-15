class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find(params)
    if params[:name]
      self.find_by_name(params[:name])
    elsif params[:description]
      self.find_by_description(params[:description])
    elsif params[:unit_price]
      self.find_by_unit_price(params[:unit_price])
    elsif params[:merchant_id]
      self.find_by_merchant_id(params[:merchant_id])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:name]
      self.where(name: params[:name])
    elsif params[:description]
      self.where(description: params[:description])
    elsif params[:unit_price]
      self.where(unit_price: params[:unit_price])
    elsif params[:merchant_id]
      self.where(merchant_id: params[:merchant_id])
    else
      "Record not found."
    end
  end
end
