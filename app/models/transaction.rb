class Transaction < ActiveRecord::Base
	attr_accessible :username, :btc, :exchangeid,:order_type,:usd
end
