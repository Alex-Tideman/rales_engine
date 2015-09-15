class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    if params[:status]
      respond_with Invoice.find_by_status(params[:status])
      elsif params[:merchant_id]
        respond_with Invoice.find_by_merchant_id(params[:merchant_id])
    elsif params[:customer_id]
      respond_with Invoice.find_by_customer_id(params[:customer_id])
    elsif params[:id]
      respond_with Invoice.find_by_id(params[:id])
    else
      respond_with "Record not found."
    end
  end

  def find_all
    if params[:status]
      respond_with Invoice.where(status: params[:status])
    elsif params[:merchant_id]
      respond_with Invoice.where(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      respond_with Invoice.where(customer_id: params[:customer_id])
    else
      respond_with "Record not found."
    end
  end

  def random
    respond_with Invoice.limit(1).order("RANDOM()")
  end

  def transactions
    respond_with Invoice.find_by(id: params[:id]).transactions
  end

  def invoice_items
    respond_with Invoice.find_by(id: params[:id]).invoice_items
  end

  def items
    respond_with Invoice.find_by(id: params[:id]).items
  end

  def customer
    respond_with Invoice.find_by(id: params[:id]).customer
  end

  def merchant
    respond_with Invoice.find_by(id: params[:id]).merchant
  end
end
