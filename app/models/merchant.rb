class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.find(params)
    if params[:name]
      self.find_by_name(params[:name])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:name]
      self.where(name: params[:name])
    else
      "Record not found."
    end
  end

end
