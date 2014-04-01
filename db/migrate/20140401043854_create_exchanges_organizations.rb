class CreateExchangesOrganizations < ActiveRecord::Migration
  def change
    create_table :exchanges_organizations, :id => false do |t|
    	t.references :exchange
    	t.references :organization
    end
    add_index :exchanges_organizations, :organization_id
  end

  def self.down
  	drop_table :exchanges_organizations
  end

end
