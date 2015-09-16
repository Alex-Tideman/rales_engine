class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.find_by(transactions_params)
  end

  def find_all
    respond_with Transaction.where(transactions_params)
  end

  def random
    respond_with Transaction.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with Transaction.find_by(id: params[:transaction_id]).invoice
  end

  private

  def transactions_params
    params.permit(:id,:credit_card_number,:result,:invoice_id,:created_at,:updated_at)
  end

end
