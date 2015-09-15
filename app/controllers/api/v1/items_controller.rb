class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    if params[:name]
      respond_with Item.find_by_name(params[:name])
    elsif params[:description]
      respond_with Item.find_by_description(params[:description])
    elsif params[:unit_price]
      respond_with Item.find_by_unit_price(params[:unit_price])
    elsif params[:merchant_id]
      respond_with Item.find_by_merchant_id(params[:merchant_id])
    elsif params[:id]
      respond_with Item.find_by_id(params[:id])
    else
      respond_with "Record not found."
    end
  end

  def find_all
    if params[:name]
      respond_with Item.where(name: params[:name])
    elsif params[:description]
      respond_with Item.where(description: params[:description])
    elsif params[:unit_price]
      respond_with Item.where(unit_price: params[:unit_price])
    elsif params[:merchant_id]
      respond_with Item.where(merchant_id: params[:merchant_id])
    else
      respond_with "Record not found."
    end
  end

  def random
    respond_with Item.limit(1).order("RANDOM()")
  end

  def invoice_items
    respond_with Item.find_by(id: params[:id]).invoice_items
  end

  def merchant
    respond_with Item.find_by(id: params[:id]).merchant
  end
end
