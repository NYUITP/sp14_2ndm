class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|
      t.datetime :time
      t.decimal :coinbase
      t.decimal :bitstamp

      t.timestamps
    end
  end
end
