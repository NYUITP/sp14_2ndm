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
		@cb3 = @coinbase.sell_price(1).format
		#@coinbase_bal = @coinbase.balance
		#Holding.all.where(:user_id => current_user.id).each do |holding|
			#@total = @total + holding.balance
		#end
	end
  end 
  def ticker
  	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
  	response = "{\"bitstamp_buy\":\""+ Bitstamp::ticker.ask.to_s+"\",\"coinbase_buy\":\""+ @coinbase.buy_price(1).format+"\",\"bitstamp_sell\":\""+ Bitstamp::ticker.bid.to_s+"\",\"coinbase_sell\":\""+ @coinbase.sell_price(1).format+"\"}"
  	#response = "{\"bitstamp\":\""+ 500.to_s+"\",\"coinbase\":\""+ @coinbase.buy_price(1).format+"\"}"
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
		response2 = RestClient.get 'http://localhost:4000/coinbase_svcs/balance?key=oo&signature=ooo'
		data2 = JSON.load response2
		print data2
	  	reply = "{\"bitstamp\":\""+ data['btc_balance'] +"\",\"coinbase\":\""+ data2['amount']+"\"}"
	  	render :json => reply
  end

  #def history
 	#if user_signed_in?
	        #base_url = "https://www.bitstamp.net/api/ticker"
		#response = RestClient.get base_url
		#data = JSON.load response
		#@bitstamp_his = 500
	#	@bitstamp_his = Bitstamp::ticker.last.to_f
	#	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
	 # 	@coinbase_his = @coinbase.buy_price(1).to_f
	#	x = PriceHistory.new
	 # 	x.bitstamp = @bitstamp_his
	  #	x.coinbase= @coinbase_his
		#x.save
		#response = PriceHistory.all		
		#render :json => response

		
	#end
  #end 

  def history
 	if user_signed_in?
	     #base_url = "https://www.bitstamp.net/api/ticker"
		#response = RestClient.get base_url
		#data = JSON.load response
		#@bitstamp_his = data["last"].to_f
		#@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
	 	#@coinbase_his = @coinbase.buy_price(1).to_f
		#x = PriceHistory.new
	 	#x.Bitstamp = @bitstamp_his
	  	#x.Coinbase= @coinbase_his
		#x.save
		response = PriceHistory.all		
		render :json => response


	end
   end

def alertsView
if user_signed_in?
	@alerts = Alerts.all
end
end
end
