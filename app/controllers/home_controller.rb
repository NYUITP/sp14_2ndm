require 'rest-client'
require 'json'

class HomeController < ApplicationController
  def index
  	if user_signed_in?
		@holdings = Holding.all
		#base_url = "https://www.bitstamp.net/api/transactions/"
		#response = RestClient.get base_url
		#data = JSON.load response
		#@bitstamp_his = data
		#@bitstamp_bal = Bitstamp.balance

		#@total = 0
		@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
		@cb2 = @coinbase.buy_price(1).format
		#@coinbase_bal = @coinbase.balance
		#Holding.all.where(:user_id => current_user.id).each do |holding|
			#@total = @total + holding.balance
		#end
	end
  end 
  def ticker
  	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
  	#response = "{\"bitstamp\":\""+ Bitstamp::ticker.last.to_s+"\",\"coinbase\":\""+ @coinbase.buy_price(1).format+"\"}"
  	response = "{\"bitstamp\":\""+ 500.to_s+"\",\"coinbase\":\""+ @coinbase.buy_price(1).format+"\"}"
  	render :json => response
  end  
  def balance
	  	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
	  	base_url = "http://localhost:4000/bitstamp_svcs/balance"
	  	print "i am here 1"
	  	#response = RestClient.get base_url
		
		#resource = RestClient::Resource.new 'http://localhost:4000/bitstamp_svcs/balance' 
		response = RestClient.get 'http://localhost:4000/bitstamp_svcs/balance?key=oo&signature=ooo&nonce=ijijiji'
		data = JSON.load response
		print data
	  	reply = "{\"bitstamp\":\""+ data['btc_balance'] +"\",\"coinbase\":\""+ @coinbase.balance.fractional.to_s+"\"}"
	  	render :json => reply

  end 
end
