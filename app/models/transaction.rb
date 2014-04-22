class Transaction < ActiveRecord::Base
	#protected_attributes nil
	#attr_accessible :username, :btc, :exchangeid,:order_type,:usd, :exchange
	attr_protected nil
	belongs_to :exchange
end
