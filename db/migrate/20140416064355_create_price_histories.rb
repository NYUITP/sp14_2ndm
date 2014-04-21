class CreatePriceHistories < ActiveRecord::Migration
  def change
    create_table :price_histories do |t|
      t.decimal :Coinbase
      t.decimal :Bitstamp

      t.timestamps
    end
  end
end
