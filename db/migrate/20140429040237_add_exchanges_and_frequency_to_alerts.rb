class AddExchangesAndFrequencyToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :exchange1, :string
    add_column :alerts, :exchange2, :string
    add_column :alerts, :frequency, :integer
  end
end
