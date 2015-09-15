class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

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
    respond_with Customer.find_by(id: params[:id]).invoices
  end

  def transactions
    respond_with Customer.find_by(id: params[:id]).joins(:invoices).transactions
  end

end
