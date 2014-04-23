class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.string :name
      t.decimal :balance

      t.timestamps
    end
  end
end
