class RemoveUserIdFromTransaction < ActiveRecord::Migration
  def change
    remove_column :transactions, :userid, :integer
  end
end
