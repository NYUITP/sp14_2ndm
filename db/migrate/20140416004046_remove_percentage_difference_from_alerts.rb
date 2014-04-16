class RemovePercentageDifferenceFromAlerts < ActiveRecord::Migration
  def change
    remove_column :alerts, :percentage_difference, :float
  end
end
