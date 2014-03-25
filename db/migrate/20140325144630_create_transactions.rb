class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :userid
      t.timestamp :time
      t.decimal :btc
      t.decimal :usd
      t.integer :exchangeid

      t.timestamps
    end
  end
end
