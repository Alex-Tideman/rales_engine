class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    respond_with Item.find(params)
  end

  def find_all
    respond_with Item.find_all(params)
  end

  def random
    respond_with Item.limit(1).order("RANDOM()")
  end

  def invoice_items
    respond_with Item.find_by(id: params[:item_id]).invoice_items
  end

  def merchant
    respond_with Item.find_by(id: params[:item_id]).merchant
  end

  def most_revenue
    respond_with Item.most_revenue(params)
  end

  def most_items
    respond_with Item.most_items(params)
  end

end
