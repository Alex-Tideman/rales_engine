class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find(params)
    search = params.downcase
    respond_with Customer.find_by(search: params[search])
  end

end
