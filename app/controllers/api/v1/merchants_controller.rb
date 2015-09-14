class Api::V1::MerchantsController < ApplicationController
  respond_to :html,:json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end
  
  def find
    if params[:id]
      respond_with Merchant.find_by(id: params[:id])
    elsif params[:name]
      respond_with Merchant.find_by(name: params[:name])
    end
  end

end
