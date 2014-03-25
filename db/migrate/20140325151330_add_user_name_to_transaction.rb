class AddUserNameToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :username, :string
  end
end
