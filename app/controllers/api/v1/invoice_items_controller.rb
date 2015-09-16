class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find_by(invoice_items_params)
  end

  def find_all
    respond_with InvoiceItem.where(invoice_items_params)
  end

  def random
    respond_with InvoiceItem.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with InvoiceItem.find_by(id: params[:invoice_item_id]).invoice
  end

  def item
    respond_with InvoiceItem.find_by(id: params[:invoice_item_id]).item
  end

  private

  def invoice_items_params
    params.permit(:id,:quantity,:unit_price,:item_id,:invoice_id,:created_at,:updated_at)
  end

end
