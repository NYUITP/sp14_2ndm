class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.integer :nonce
      t.string :signature
      t.string :apikey

      t.timestamps
    end
  end
end
