class RemoveOrganizationIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :OrganizationId, :integer
  end
end
