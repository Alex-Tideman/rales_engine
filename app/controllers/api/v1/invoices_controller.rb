class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    respond_with Invoice.find(params)
  end

  def find_all
    respond_with Invoice.find_all(params)
  end

  def random
    respond_with Invoice.limit(1).order("RANDOM()")
  end

  def transactions
    respond_with Invoice.find_by(id: params[:invoice_id]).transactions
  end

  def invoice_items
    respond_with Invoice.find_by(id: params[:invoice_id]).invoice_items
  end

  def items
    respond_with Invoice.find_by(id: params[:invoice_id]).items
  end

  def customer
    respond_with Invoice.find_by(id: params[:invoice_id]).customer
  end

  def merchant
    respond_with Invoice.find_by(id: params[:invoice_id]).merchant
  end
end
