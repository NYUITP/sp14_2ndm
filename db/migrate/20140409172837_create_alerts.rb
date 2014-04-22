class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.belongs_to :user
      t.float :price_range
      t.float :percentage_difference

      t.timestamps
    end
  end
end
