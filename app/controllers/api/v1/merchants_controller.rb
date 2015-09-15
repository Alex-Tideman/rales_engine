class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    if params[:name]
      respond_with Merchant.find_by_name(params[:name])
    elsif params[:id]
      respond_with Merchant.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def find_all
    if params[:name]
      respond_with Merchant.where(name: params[:name])
    else
      "Record not found."
    end
  end

  def random
    respond_with Merchant.limit(1).order("RANDOM()")
  end

  def items
    respond_with Merchant.find_by(id: params[:id]).items
  end

  def invoices
    respond_with Merchant.find_by(id: params[:id]).invoices
  end

end
