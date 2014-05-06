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
	diff = (@coinbase.buy_price(1).to_f - data["last"].to_f).abs
	#diff = (@coinbase.buy_price(1).to_f - 10.0).abs
        
  alerts = Alert.all
    alerts.each do |item|
        @alert = item
		timeDifference = ((Time.now.utc - @alert.updated_at) / 1.minute).round
        if(timeDifference % @alert.frequency == 0) then

			if @alert.price_difference <= diff then
			#send email alert
			AlertMailer.send_alert(@alert).deliver  

			if @alert.automatic? then
				btcval = @alert.quantity.to_s
				usdval = (@alert.quantity*(data["last"].to_f)).to_s
				username = @alert.user.username
				params = {'transaction' => {'btc' => btcval, 'usd' => usdval, 'exchangeid'=>'1', 'order_type'=>'Limit Buy', 'username' => username} }
				print params.to_json
				RestClient.post "http://localhost:3000/transactions", params.to_json, :content_type => :json, :accept => :json
				delete_url = "http://localhost:3000/alerts/"+@alert.id.to_s
				print delete_url
				RestClient.delete delete_url
			end

		    end
      	end
    end
  end
end





  
