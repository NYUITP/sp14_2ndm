class AddActionToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :type, :string
  end
end
