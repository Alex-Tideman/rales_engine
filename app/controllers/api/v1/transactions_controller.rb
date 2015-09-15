class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    if params[:credit_card_number]
      respond_with Transaction.find_by_credit_card_number(params[:credit_card_number])
    elsif params[:result]
      respond_with Transaction.find_by_result(params[:result])
    elsif params[:invoice_id]
      respond_with Transaction.find_by_invoice_id(params[:invoice_id])
    elsif params[:id]
      respond_with Transaction.find_by_id(params[:id])
    else
      respond_with "Record not found."
    end
  end

  def find_all
    if params[:credit_card_number]
      respond_with Transaction.where(credit_card_number: params[:credit_card_number])
    elsif params[:result]
      respond_with Transaction.where(result: params[:result])
    elsif params[:invoice_id]
      respond_with Transaction.where(invoice_id: params[:invoice_id])
    else
      respond_with "Record not found."
    end
  end

  def random
    respond_with Transaction.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with Transaction.find_by(id: params[:id]).invoice
  end
end
