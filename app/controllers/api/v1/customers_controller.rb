class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    if params[:first_name]
      respond_with Customer.find_by_first_name(params[:first_name])
    elsif params[:last_name]
      respond_with Customer.find_by_last_name(params[:last_name])
    elsif params[:id]
      respond_with Customer.find_by_id(params[:id])
    else
      respond_with "Record not found."
    end
  end

  def find_all
    if params[:first_name]
      respond_with Customer.where(first_name: params[:first_name])
    elsif params[:last_name]
      respond_with Customer.where(last_name: params[:last_name])
    else
      respond_with "Record not found."
    end
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
