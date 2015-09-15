class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find(params)
  end

  def find_all
    respond_with Merchant.find_all(params)
  end

  def random
    respond_with Merchant.limit(1).order("RANDOM()")
  end

  def items
    respond_with Merchant.find_by(id: params[:merchant_id]).items
  end

  def invoices
    respond_with Merchant.find_by(id: params[:merchant_id]).invoices
  end

  def most_revenue
    respond_with Merchant.most_revenue(params)
  end

  def most_items
    respond_with Merchant.most_items(params)
  end

  def revenue
    respond_with Merchant.revenue(params[:date])
  end


end
