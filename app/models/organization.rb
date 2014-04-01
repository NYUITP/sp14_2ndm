class Organization < ActiveRecord::Base
	attr_protected nil
	has_many :users
	has_and_belongs_to_many :exchanges
	def display_name
    	organization_name
  	end
  validates_presence_of :organization_name
end
