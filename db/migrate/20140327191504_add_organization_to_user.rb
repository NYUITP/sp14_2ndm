class AddOrganizationToUser < ActiveRecord::Migration
  def change
    add_column :users, :OrganizationId, :integer
  end
end
