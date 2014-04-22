class AddExchangeToTransaction < ActiveRecord::Migration
  def change
  	add_reference :transactions, :exchange, index: true
  end
end
