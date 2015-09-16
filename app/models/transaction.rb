class Transaction < ActiveRecord::Base
  belongs_to :invoice

  def self.success
    where(result: 'success')
  end
end
