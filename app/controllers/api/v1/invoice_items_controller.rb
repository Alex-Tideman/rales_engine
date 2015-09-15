class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    if params[:quantity]
      respond_with InvoiceItem.find_by_quantity(params[:quantity])
    elsif params[:unit_price]
      respond_with InvoiceItem.find_by_unit_price(params[:unit_price])
    elsif params[:item_id]
      respond_with InvoiceItem.find_by_item_id(params[:item_id])
    elsif params[:invoice_id]
      respond_with InvoiceItem.find_by_invoice_id(params[:invoice_id])
    elsif params[:id]
      respond_with InvoiceItem.find_by_id(params[:id])
    else
      respond_with "Record not found."
    end
  end

  def find_all
    if params[:quantity]
      respond_with InvoiceItem.where(quantity: params[:quantity])
    elsif params[:unit_price]
      respond_with InvoiceItem.where(unit_price: params[:unit_price])
    elsif params[:item_id]
      respond_with InvoiceItem.where(item_id: params[:item_id])
    elsif params[:invoice_id]
      respond_with InvoiceItem.where(invoice_id: params[:invoice_id])
    else
      respond_with "Record not found."
    end
  end

  def random
    respond_with InvoiceItem.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with InvoiceItem.find_by(id: params[:id]).invoice
  end

  def item
    respond_with InvoiceItem.find_by(id: params[:id]).item
  end

end
