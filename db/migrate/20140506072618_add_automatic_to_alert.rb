class AddAutomaticToAlert < ActiveRecord::Migration
  def change
    add_column :alerts, :automatic, :boolean, :default => false, :null => false
    add_column :alerts, :quantity, :decimal
  end
end
