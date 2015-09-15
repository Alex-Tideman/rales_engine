class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.find(params)
    if params[:first_name]
      self.find_by_first_name(params[:first_name])
    elsif params[:last_name]
      self.find_by_last_name(params[:last_name])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:first_name]
      self.where(first_name: params[:first_name])
    elsif params[:last_name]
      self.where(last_name: params[:last_name])
    else
      "Record not found."
    end
  end

  def self.transactions
    self.joins(:invoices)
  end
end
