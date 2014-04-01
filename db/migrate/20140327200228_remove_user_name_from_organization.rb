class RemoveUserNameFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :user_name, :string
  end
end
