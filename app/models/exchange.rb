class Exchange < ActiveRecord::Base
  
  #attr_accessible :exchange_attributes
  #validates_presence_of :name, :nonce, :signature, :apikey, :case_sensitive => true
  attr_protected nil
  validates_presence_of :name, :nonce, :signature, :apikey, :case_sensitive => true
end

