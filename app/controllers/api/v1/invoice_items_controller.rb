class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find(params)
  end

  def find_all
    respond_with InvoiceItem.find_all(params)
  end

  def random
    respond_with InvoiceItem.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with InvoiceItem.find_by(id: params[:id]).invoice
  end

  def item
    respond_with InvoiceItem.find_by(id: params[:id]).item
  end

end
