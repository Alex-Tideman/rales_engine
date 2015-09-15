class Transaction < ActiveRecord::Base
  belongs_to :invoice

  def self.find(params)
    if params[:credit_card_number]
      self.find_by_credit_card_number(params[:credit_card_number])
    elsif params[:result]
      self.find_by_result(params[:result])
    elsif params[:invoice_id]
      self.find_by_invoice_id(params[:invoice_id])
    elsif params[:id]
      self.find_by_id(params[:id])
    else
      "Record not found."
    end
  end

  def self.find_all(params)
    if params[:credit_card_number]
      self.where(credit_card_number: params[:credit_card_number])
    elsif params[:result]
      self.where(result: params[:result])
    elsif params[:invoice_id]
      self.where(invoice_id: params[:invoice_id])
    else
      "Record not found."
    end
  end

  def self.success
    where(result: 'success')
  end
end
