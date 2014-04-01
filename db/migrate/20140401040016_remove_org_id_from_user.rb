class RemoveOrgIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :orgid, :integer
  end
end
