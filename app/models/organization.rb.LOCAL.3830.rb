class Organization < ActiveRecord::Base
	attr_protected nil
  #validates_presence_of :organization_name, :user_name
  validates_presence_of :organization_name
end
