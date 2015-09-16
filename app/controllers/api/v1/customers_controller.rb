class Api::V1::CustomersController < ApplicationController
  respond_to :json
  
  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find(params)
  end

  def find_all
    respond_with Customer.find_all(params)
  end

  def random
    respond_with Customer.limit(1).order("RANDOM()")
  end

  def invoices
    respond_with Customer.find_by(id: params[:customer_id]).invoices
  end

  def transactions
    respond_with Customer.find_by(id: params[:customer_id]).transactions
  end

  def favorite_merchant
    respond_with Customer.find_by(id: params[:customer_id]).favorite_merchant
  end

end
