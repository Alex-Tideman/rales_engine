class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  def self.find(params)
    if params[:quantity]
      self.find_by_quantity(params[:quantity])
    elsif params[:unit_price]
      self.find_by_unit_price(params[:unit_price])
    elsif params[:item_id]
      self.find_by_item_id(params[:item_id])
    elsif params[:invoice_id]
      self.find_by_invoice_id(params[:invoice_id])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:quantity]
      self.where(quantity: params[:quantity])
    elsif params[:unit_price]
      self.where(unit_price: params[:unit_price])
    elsif params[:item_id]
      self.where(item_id: params[:item_id])
    elsif params[:invoice_id]
      self.where(invoice_id: params[:invoice_id])
    else
      "Record not found."
    end
  end
end
