require 'rest-client'
require 'json'
require 'coinbase'

class CoinbaseSvcsController < ApplicationController

  def bal
      if(params[:key] != nil && params[:signature] != nil)
      #response = "{\"usd_balance\":\"100000\",\"btc_balance\":\""+Balances.where(:name => "Coinbase").first.balance.to_s+"\",\"usd_reserved\":\"30000\",\"btc_reserved\":\"60\",\"usd_available\":\"100000\",\"btc_available\":\"200\",\"fee\":\"20\"}"
      
      response = "{
  \"amount\": \""+Balances.where(:name => "Coinbase").first.balance.to_s+"\",
  \"currency\": \"BTC\"
}"

      render :json => response
      end
  end
  def buy
  	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
  	if(params[:key] != nil && params[:signature] != nil)
      #response = "{\"id\":\""+SecureRandom.uuid.to_s+"\",\"datetime\":\""+Time.now.to_s+"\",\"type\":\"0\",\"price\":\""+(params[:price].to_f*params[:amount].to_f).to_s+"\",\"amount\":\""+params[:amount].to_s+"\"}"
      subamt = (@coinbase.buy_price(1)*(params[:qty].to_f))
      fee = 0.34
      response = "{
  					\"success\": true,
  					\"transfer\": {
    				\"type\": \"Buy\",
    				\"code\": \""+SecureRandom.uuid.to_s+"\",
    				\"created_at\": \""+Time.now.to_s+"\",
    				\"fees\": {
      					\"coinbase\": {
        					\"cents\": 14,
        					\"currency_iso\": \"USD\"
      					},
      					\"bank\": {
							\"cents\": 15,
							\"currency_iso\": \"USD\"
						}
    				},
				    \"status\": \"created\",
				    \"payout_date\": \""+SecureRandom.uuid.to_s+"\",
				    \"btc\": {
				      \"amount\": \""+params[:qty]+"\",
				      \"currency\": \"BTC\"
				    },
				    \"subtotal\": {
				      \"amount\": \""+subamt.to_s+"\",
				      \"currency\": \"USD\"
				    },
				    \"total\": {
				      \"amount\": \""+(subamt).to_s+"\",
				      \"currency\": \"USD\"
				    }
  }
}"

      balB = Balances.where(:name => "Coinbase").first
      varBal = balB.balance
      balB.balance = varBal + params[:qty].to_f
      balB.save
      render :json => response
      end
  end 
  def sell
  	@coinbase = Coinbase::Client.new('9MB2hsDaSXvbevZ4', 'Yakw1TObmQrL2k4OMGcCVZqpdNLsPO2S')
  	if(params[:key] != nil && params[:signature] != nil)
      #response = "{\"id\":\""+SecureRandom.uuid.to_s+"\",\"datetime\":\""+Time.now.to_s+"\",\"type\":\"0\",\"price\":\""+(params[:price].to_f*params[:amount].to_f).to_s+"\",\"amount\":\""+params[:amount].to_s+"\"}"
      subamt = (@coinbase.sell_price(1)*(params[:qty].to_f))
      fee = 0.34
      response = "{
  					\"success\": true,
  					\"transfer\": {
    				\"type\": \"Sell\",
    				\"code\": \""+SecureRandom.uuid.to_s+"\",
    				\"created_at\": \""+Time.now.to_s+"\",
    				\"fees\": {
      					\"coinbase\": {
        					\"cents\": 14,
        					\"currency_iso\": \"USD\"
      					},
      					\"bank\": {
							\"cents\": 15,
							\"currency_iso\": \"USD\"
						}
    				},
				    \"status\": \"created\",
				    \"payout_date\": \""+SecureRandom.uuid.to_s+"\",
				    \"btc\": {
				      \"amount\": \""+params[:qty]+"\",
				      \"currency\": \"BTC\"
				    },
				    \"subtotal\": {
				      \"amount\": \""+subamt.to_s+"\",
				      \"currency\": \"USD\"
				    },
				    \"total\": {
				      \"amount\": \""+(subamt).to_s+"\",
				      \"currency\": \"USD\"
				    }
  }
}"

      balB = Balances.where(:name => "Coinbase").first
      print balB.balance
      print "\n"
      print params[:qty]
      balB.balance = balB.balance.to_f - params[:qty].to_f
      balB.save
      render :json => response
      end
  end 

end
