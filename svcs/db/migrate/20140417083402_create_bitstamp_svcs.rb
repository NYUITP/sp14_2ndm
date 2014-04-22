class CreateBitstampSvcs < ActiveRecord::Migration
  def change
    create_table :bitstamp_svcs do |t|

      t.timestamps
    end
  end
end
