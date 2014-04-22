class AddUserIdToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :username, :string
  end
end
