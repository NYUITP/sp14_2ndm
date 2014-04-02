class Organization < ActiveRecord::Base
	attr_protected nil
<<<<<<< HEAD
  #validates_presence_of :organization_name, :user_name
=======
	has_many :users
	has_and_belongs_to_many :exchanges
	def display_name
    	organization_name
  	end
>>>>>>> master
  validates_presence_of :organization_name
end
