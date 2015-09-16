class Api::V1::MerchantsController < ApplicationController
  respond_to :json
  
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
    if params[:merchant_id] > 0
      respond_with Merchant.find_by(id: params[:merchant_id]).single_revenue(params[:date])
    else
      respond_with Merchant.total_revenue(params[:date])
    end
  end

  def favorite_customer
    respond_with Merchant.find_by(id: params[:merchant_id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find_by(id: params[:merchant_id]).customers_with_pending_invoices
  end

end
