class AddOrderTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :order_type, :string
  end
end
