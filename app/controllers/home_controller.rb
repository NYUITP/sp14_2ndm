require 'rest-client'
require 'json'

class HomeController < ApplicationController
  def index
  	if user_signed_in?
		@holdings = Holding.all
		base_url = "https://www.bitstamp.net/api/transactions/"
		response = RestClient.get base_url
		data = JSON.load response
		@bitstamp_his = data
		@total = 0
		@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
		@cb2 = @coinbase.buy_price(1).format
		Holding.all.where(:user_id => current_user.id).each do |holding|
			@total = @total + holding.balance
		end
	end
  end
  
end
