class Role < ActiveRecord::Base
  has_many :users, :through => :users_roles, :dependent => :destroy
  belongs_to :resource, :polymorphic => true
  attr_accessible :role_attributes
  resourcify
  scopify
end
