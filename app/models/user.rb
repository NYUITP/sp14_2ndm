class User < ActiveRecord::Base
  resourcify

  rolify
  attr_accessible :user_attributes
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role_ids

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username, :email, :case_sensitive => true
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
 
  before_create :assign_role
 
  def assign_role
    self.add_role :user if self.roles.first.nil?
  end

  after_create { |admin| admin.send_reset_password_instructions }
 
end
