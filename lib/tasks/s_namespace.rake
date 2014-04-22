require 'rest-client'
require 'json'

namespace :s_namespace do
  desc "rake task to fetch tickr data into tables"
 
 task priceHistory: :environment do
 	        #base_url = "https://www.bitstamp.net/api/ticker"
		#response = RestClient.get base_url
		#data = JSON.load response
		@bitstamp_his = 500
		@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
	  	@coinbase_his = @coinbase.buy_price(1).to_f
		x = PriceHistory.new
	  	x.Bitstamp = @bitstamp_his
	  	x.Coinbase= @coinbase_his
		x.save
		#Rake::Task["s_namespace:priceHistory"].execute
	end
 task trigger: :environment do
 	        Rake::Task["s_namespace:priceHistory"].execute
	end

end	
