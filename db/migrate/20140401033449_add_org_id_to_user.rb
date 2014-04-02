class AddOrgIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :orgid, :integer
  end
end
