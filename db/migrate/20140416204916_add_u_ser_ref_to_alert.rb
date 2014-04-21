class AddUSerRefToAlert < ActiveRecord::Migration
  def change
	add_reference :alerts, :user, index: false
  end
end
