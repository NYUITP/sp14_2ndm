class Holding < ActiveRecord::Base
  resourcify
  attr_accessible :holding_attributes
  belongs_to :user

  validates_presence_of :name, :user_id, :case_sensitive => false

  def self.filtered_by_userid()
     holdings = Holding.arel_table
     self.where(:user_id => current_user.id)
   end
end
