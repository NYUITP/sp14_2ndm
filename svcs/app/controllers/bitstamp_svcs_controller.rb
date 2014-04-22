require 'rest-client'
require 'json'
class BitstampSvcsController < ApplicationController

  def bal
      if(params[:key] != nil && params[:signature] != nil && params[:nonce] != nil)
      response = "{\"usd_balance\":\"100000\",\"btc_balance\":\"100\",\"usd_reserved\":\"30000\",\"btc_reserved\":\"60\",\"usd_available\":\"100000\",\"btc_available\":\"200\",\"fee\":\"20\"}"
      render :json => response
      end
  end
  def buy
  	if(params[:key] != nil && params[:signature] != nil && params[:nonce] != nil)
      response = "{\"id\":\""+SecureRandom.uuid.to_s+"\",\"datetime\":\""+Time.now.to_s+"\",\"type\":\"0\",\"price\":\""+(params[:price].to_f*params[:amount].to_f).to_s+"\",\"amount\":\""+params[:amount].to_s+"\"}"
      render :json => response
      end
  end 
  def sell
  	if(params[:key] != nil && params[:signature] != nil && params[:nonce] != nil)
      response = "{\"id\":\""+SecureRandom.uuid.to_s+"\",\"datetime\":\""+Time.now.to_s+"\",\"type\":\"1\",\"price\":\""+(params[:price].to_f*params[:amount].to_f).to_s+"\",\"amount\":\""+params[:amount].to_s+"\"}"
      render :json => response
      end
  end 

end
