class Organization < ActiveRecord::Base
	attr_protected nil
	has_many :users
	def display_name
    	organization_name
  	end
  validates_presence_of :organization_name
end
