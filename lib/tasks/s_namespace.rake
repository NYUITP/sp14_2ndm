require 'rest-client'
require 'json'

namespace :s_namespace do
  desc "rake task to fetch tickr data into tables"
 
 task priceHistory: :environment do
 	        base_url = "https://www.bitstamp.net/api/ticker/"
 	        cbUrl = "https://coinbase.com/api/v1/prices/spot_rate"
		response = RestClient.get base_url
		data = JSON.load response
		@bitstamp_his = (data["bid"].to_f + data["ask"].to_f)/2
		response2 = RestClient.get cbUrl
		data = JSON.load response2
	  	@coinbase_his = data["amount"].to_f
		x = PriceHistory.new
	  	x.bitstamp = @bitstamp_his
	  	x.coinbase= @coinbase_his
		x.save
		#Rake::Task["s_namespace:priceHistory"].execute
	end
 task trigger: :environment do
 	        Rake::Task["s_namespace:priceHistory"].execute
	end

end	
