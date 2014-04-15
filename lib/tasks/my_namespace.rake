namespace :my_namespace do
    desc "Rake task check for alerts"
    task poll: :environment do
  #alerts = Alert.all
  #  alerts.each do |item|
  #    @alert = item
#	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
#	diff = (@coinbase.buy_price(1).format - Bitstamp::Ticker.last).abs
 # 	if @alert.price_range <= diff then
		#send email alert
#	AlertMailer.alert_email(@alert).deliver  
 #       end
  #  end
    puts "Successssssssss!"
end

end





  
