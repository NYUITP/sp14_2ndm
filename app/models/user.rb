class User < ActiveRecord::Base
  resourcify

  rolify
  
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username, :email, :password, :case_sensitive => true
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false

  belongs_to :role
 
  before_create :assign_role
 
  def assign_role
    # assign a default role if no role is assigned
    self.add_role :user if self.roles.first.nil?
  end

  after_create { |admin| admin.send_reset_password_instructions }
 
end
