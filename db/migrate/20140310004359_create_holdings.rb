class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.string :name
      t.integer :user_id, :null => false, :references => [:users, :id]
      t.decimal :balance
      
      t.timestamps
    end
    
  end
end
