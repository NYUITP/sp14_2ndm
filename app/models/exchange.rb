class Exchange < ActiveRecord::Base
  
  #attr_accessible :exchange_attributes
  #validates_presence_of :name, :nonce, :signature, :apikey, :case_sensitive => true
  attr_protected nil
  has_and_belongs_to_many :organizations
  validates_presence_of :name, :nonce, :signature, :apikey, :case_sensitive => true
  def display_name
      name
  end
end

