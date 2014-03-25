class RemoveTimeFromTransaction < ActiveRecord::Migration
  def change
    remove_column :transactions, :time, :datetime
  end
end
