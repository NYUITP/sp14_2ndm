require 'rest-client'
require 'json'


namespace :my_namespace do
    desc "Rake task check for alerts"
    task poll: :environment do
    
	base_url = "https://www.bitstamp.net/api/ticker/"
	response = RestClient.get base_url
	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
	#USE SPOT PRICE
	data = JSON.load response
	#diff = (@coinbase.buy_price(1).to_f - data["last"].to_f).abs
	#diff = (@coinbase.buy_price(1).to_f - 10.0).abs
	bitstamp_buy_price = data["ask"].to_f
	bitstamp_sell_price = data["bid"].to_f
	coinbase_buy_price = @coinbase.buy_price(1).to_f
	coinbase_sell_price = @coinbase.sell_price(1).to_f
	print "bitstamp sell: " + bitstamp_sell_price.to_s + " coinbase buy: " + coinbase_buy_price.to_s + " coinbase sell: " + coinbase_sell_price.to_s + " bitstamp buy:" + bitstamp_buy_price.to_s

	diff1 = (bitstamp_sell_price - coinbase_buy_price)
	diff2 = (coinbase_sell_price - bitstamp_buy_price)

  	alerts = Alert.all
    alerts.each do |item|
        @alert = item
		timeDifference = ((Time.now.utc - @alert.updated_at) / 1.minute).round
        if(timeDifference % @alert.frequency == 0) then

			if @alert.price_difference <= diff1 || @alert.price_difference <= diff2 then
			#send email alert
				AlertMailer.send_alert(@alert).deliver  

				if @alert.automatic? then
					if(diff1 > diff2) then
						print 'here1'
						btcval = @alert.quantity.to_s
						username = @alert.user.username
						params = {'transaction' => {'btc' => btcval, 'usd' => bitstamp_sell_price.to_s, 'exchangeid'=>'1', 'order_type'=>'Limit Sell', 'username' => username} }
						RestClient.post "http://localhost:3000/transactions", params.to_json, :content_type => :json, :accept => :json
						params2 = {'transaction' => {'btc' => btcval, 'usd' => '0', 'exchangeid'=>'2', 'order_type'=>'Market Buy', 'username' => username} }
						RestClient.post "http://localhost:3000/transactions", params2.to_json, :content_type => :json, :accept => :json
						
						delete_url = "http://localhost:3000/alerts/"+@alert.id.to_s
						RestClient.delete delete_url
					elsif (diff2 > diff1)
						print 'here2'
						btcval = @alert.quantity.to_s
						username = @alert.user.username
						params2 = {'transaction' => {'btc' => btcval, 'usd' => '0', 'exchangeid'=>'2', 'order_type'=>'Market Sell', 'username' => username} }
						RestClient.post "http://localhost:3000/transactions", params2.to_json, :content_type => :json, :accept => :json
						params = {'transaction' => {'btc' => btcval, 'usd' => bitstamp_buy_price.to_s, 'exchangeid'=>'1', 'order_type'=>'Limit Buy', 'username' => username} }
						RestClient.post "http://localhost:3000/transactions", params.to_json, :content_type => :json, :accept => :json
						
						delete_url = "http://localhost:3000/alerts/"+@alert.id.to_s
						RestClient.delete delete_url
					end
				end

		    end
      	end
    end
  end
end





  
