class FixColumnName < ActiveRecord::Migration
   def self.up
    rename_column :alerts, :price_range, :price_difference
  end
end
